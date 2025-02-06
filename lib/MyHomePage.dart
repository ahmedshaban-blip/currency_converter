import 'package:currency_converter/cubit/currency_converter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CurrencyConverterScreen extends StatefulWidget {
  const CurrencyConverterScreen({super.key});

  @override
  _CurrencyConverterScreenState createState() => _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CurrencyConverterCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text('محول العملات')),
        body: BlocConsumer<CurrencyConverterCubit, CurrencyConverterState>(
          listener: (context, state) {
            if (state.errorMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage!)),
              );
            }
          },
          builder: (context, state) {
            final cubit = BlocProvider.of<CurrencyConverterCubit>(context);
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: _amountController,
                    decoration: const InputDecoration(
                      labelText: 'أدخل المبلغ',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(child: _buildCurrencyDropdown(
                        value: state.fromCurrency,
                        onChanged: cubit.updateFromCurrency,
                        label: 'من',
                        currencies: state.currencies,
                      )),
                      IconButton(
                        icon: const Icon(Icons.swap_horiz),
                        onPressed: cubit.swapCurrencies,
                      ),
                      Expanded(child: _buildCurrencyDropdown(
                        value: state.toCurrency,
                        onChanged: cubit.updateToCurrency,
                        label: 'إلى',
                        currencies: state.currencies,
                      )),
                    ],
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () => cubit.convert(double.parse(_amountController.text)),
                    child: const Text('Convert'),
                  ),
                  if (state.isLoading) const CircularProgressIndicator(),
                  if (state.convertedAmount != null)
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'النتيجة: ${NumberFormat.currency(symbol: '').format(state.convertedAmount)} ${state.toCurrency}',
                        style: const TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCurrencyDropdown({
    required String value,
    required ValueChanged<String> onChanged,
    required String label,
    required List<String> currencies,
  }) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          items: currencies.map((currency) {
            return DropdownMenuItem<String>(
              value: currency,
              child: Text(currency),
            );
          }).toList(),
          onChanged: (value) => onChanged(value!),
        ),
      ),
    );
  }
}