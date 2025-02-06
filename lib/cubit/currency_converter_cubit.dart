import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:currency_converter/Api/apiConvert.dart';

part 'currency_converter_state.dart';

class CurrencyConverterCubit extends Cubit<CurrencyConverterState> {
  CurrencyConverterCubit() : super(const CurrencyConverterState(currencies: [])) {
    loadCurrencies();
  }

  Future<void> loadCurrencies() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final rates = await fetchExchangeRates(state.fromCurrency);
      final currencies = rates['conversion_rates'].keys.toList()..sort();
      emit(state.copyWith(
        currencies: currencies,
        isLoading: false,
        fromCurrency: currencies.contains(state.fromCurrency) ? state.fromCurrency : 'USD',
        toCurrency: currencies.contains(state.toCurrency) ? state.toCurrency : 'EGP',
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load currencies: $e',
      ));
    }
  }

  void swapCurrencies() {
    emit(state.copyWith(
      fromCurrency: state.toCurrency,
      toCurrency: state.fromCurrency,
    ));
    loadCurrencies();
  }

  void updateFromCurrency(String currency) {
    emit(state.copyWith(fromCurrency: currency));
    loadCurrencies();
  }

  void updateToCurrency(String currency) {
    emit(state.copyWith(toCurrency: currency));
  }

  Future<void> convert(double amount) async {
    if (amount <= 0) return;
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final rates = await fetchExchangeRates(state.fromCurrency);
      final rate = rates['conversion_rates'][state.toCurrency];
      final converted = amount * rate;
      emit(state.copyWith(
        convertedAmount: converted,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Conversion failed: $e',
      ));
    }
  }
}