import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchExchangeRates(String baseCurrency) async {
  // تم تصحيح عنوان URL وإزالة التكرار
  final url = 'https://v6.exchangerate-api.com/v6/fa21dc0ff1187014f50ed54a/latest/$baseCurrency';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    print('Error: ${response.statusCode} - ${response.body}');
    throw Exception('Failed to load exchange rates');
  }
}
