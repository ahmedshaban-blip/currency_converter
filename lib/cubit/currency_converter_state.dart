part of 'currency_converter_cubit.dart';

@immutable
class CurrencyConverterState {
  final List<String> currencies;
  final String fromCurrency;
  final String toCurrency;
  final double? convertedAmount;
  final bool isLoading;
  final String? errorMessage;

  const CurrencyConverterState({
    required this.currencies,
    this.fromCurrency = 'USD',
    this.toCurrency = 'EGP',
    this.convertedAmount,
    this.isLoading = false,
    this.errorMessage,
  });

  CurrencyConverterState copyWith({
    List<String>? currencies,
    String? fromCurrency,
    String? toCurrency,
    double? convertedAmount,
    bool? isLoading,
    String? errorMessage,
  }) {
    return CurrencyConverterState(
      currencies: currencies ?? this.currencies,
      fromCurrency: fromCurrency ?? this.fromCurrency,
      toCurrency: toCurrency ?? this.toCurrency,
      convertedAmount: convertedAmount ?? this.convertedAmount,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}