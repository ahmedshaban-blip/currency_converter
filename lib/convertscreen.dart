import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:currency_converter/Api/apiConvert.dart'; // تأكد من صحة مسار الملف

class CurrencyConverterScreen extends StatefulWidget {
  const CurrencyConverterScreen({super.key});

  @override
  _CurrencyConverterScreenState createState() => _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  final TextEditingController _amountController = TextEditingController();
  String _fromCurrency = 'USD';
  String _toCurrency = 'EGP'; // تعيين الجنيه المصري كعملة افتراضية للوجهة
  double? _convertedAmount;
  bool _isLoading = false;
  List<String> _currencies = []; // سيتم تحميل العملات ديناميكيًا

  // دالة مساعدة لتحويل العملة
  double convertCurrency(double amount, double rate) {
    return amount * rate;
  }

  @override
  void initState() {
    super.initState();
    _loadCurrencies();
  }

  // تحميل قائمة العملات من API لاستخدامها في القوائم المنسدلة
  Future<void> _loadCurrencies() async {
    try {
      // يتم جلب أسعار الصرف باستخدام العملة الافتراضية (مثلاً USD)
      final rates = await fetchExchangeRates(_fromCurrency);
      setState(() {
        // استخراج مفاتيح العملات من الاستجابة وإعادة ترتيبها
        _currencies = rates['conversion_rates'].keys.toList();
        _currencies.sort();
        // التأكد من أن العملات الافتراضية موجودة في القائمة
        if (!_currencies.contains(_fromCurrency)) {
          _fromCurrency = _currencies.first;
        }
        if (!_currencies.contains(_toCurrency)) {
          _toCurrency = _currencies.contains('EGP') ? 'EGP' : _currencies.first;
        }
      });
    } catch (e) {
      print("Error loading currencies: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ أثناء تحميل العملات: $e')),
      );
    }
  }

  Future<void> _fetchConversionRate() async {
    double amount = double.tryParse(_amountController.text) ?? 0;

    setState(() {
      _isLoading = true;
    });

    try {
      final rates = await fetchExchangeRates(_fromCurrency);
      final rate = rates['conversion_rates'][_toCurrency];
      setState(() {
        _convertedAmount = convertCurrency(amount, rate);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buildCurrencyDropdown({
    required String value,
    required ValueChanged<String?> onChanged,
    required String label,
  }) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          items: _currencies.map((String currency) {
            return DropdownMenuItem<String>(
              value: currency,
              child: Text(currency),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('محول العملات'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: 'أدخل المبلغ',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildCurrencyDropdown(
                    value: _fromCurrency,
                    onChanged: (value) {
                      setState(() {
                        _fromCurrency = value!;
                      });
                    },
                    label: 'من',
                  ),
                ),
                SizedBox(width: 20),
                IconButton(
                  icon: Icon(Icons.swap_horiz),
                  onPressed: () {
                    setState(() {
                      final temp = _fromCurrency;
                      _fromCurrency = _toCurrency;
                      _toCurrency = temp;
                    });
                  },
                ),
                SizedBox(width: 20),
                Expanded(
                  child: _buildCurrencyDropdown(
                    value: _toCurrency,
                    onChanged: (value) {
                      setState(() {
                        _toCurrency = value!;
                      });
                    },
                    label: 'إلى',
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _fetchConversionRate,
              child: Text('Convert'),
            ),
            SizedBox(height: 30),
            if (_isLoading)
              Center(child: CircularProgressIndicator()),
            if (_convertedAmount != null)
              Card(
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'النتيجة: ${NumberFormat.currency(symbol: '').format(_convertedAmount)} $_toCurrency',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
