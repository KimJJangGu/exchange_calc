import 'dart:async';

import 'package:exchange_calc/core/result.dart';
import 'package:exchange_calc/domain/model/exchange_model.dart';
import 'package:exchange_calc/domain/use_case/calc_exchange_use_case.dart';
import 'package:exchange_calc/domain/use_case/get_exchange_use_case.dart';
import 'package:exchange_calc/presenter/exchange_state.dart';
import 'package:flutter/material.dart';

class ExchangeViewModel extends ChangeNotifier {
  final GetExchangeUseCase _exchangeUseCase;
  final CalcExchangeUseCase _calcExchangeUseCase;

  ExchangeViewModel({required CalcExchangeUseCase calcExchangeUseCase, required GetExchangeUseCase exchangeUseCase}) :
        _calcExchangeUseCase = calcExchangeUseCase,
        _exchangeUseCase = exchangeUseCase;

  ExchangeState _state = const ExchangeState();
  ExchangeState get state => _state;

  final StreamController<num> _destController = StreamController();
  Stream<num> get destStream => _destController.stream;

  final StreamController<num> _srcController = StreamController();
  Stream<num> get srcStream => _srcController.stream;

  Future<void> getCurrencyExchange() async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    Result<ExchangeModel> result = await _exchangeUseCase.execute();

    switch (result) {
      case Success<ExchangeModel>():
        _state = state.copyWith(isLoading: false, exchangeModel: result.data);
      case Error<ExchangeModel>():
        _state = state.copyWith(isLoading: false, exchangeModel: null);
    }
    notifyListeners();
  }

  void selectSourceValue(String value) {
    try {
      num parseValue = _calcExchangeUseCase.execute(value, state.exchangeModel!.exchangeRates[state.sourceUnit]!, state.exchangeModel!.exchangeRates[state.destUnit]!);
      _destController.add(parseValue);
    } catch (e) {
      _destController.add(0);
    }
  }

  void selectDestValue(String value) {
    try {
      num parseValue = _calcExchangeUseCase.execute(value, state.exchangeModel!.exchangeRates[state.destUnit]!, state.exchangeModel!.exchangeRates[state.sourceUnit]!);
      _srcController.add(parseValue);
    } catch (e) {
      _srcController.add(0);
    }
  }

  void selectSource(String unit, String value) {
    _state = state.copyWith(sourceUnit: unit);
    selectSourceValue(value);
    notifyListeners();
  }

  void selectDest(String unit, String value) {
    _state = state.copyWith(destUnit: unit);
    selectSourceValue(value);
    notifyListeners();
  }
}