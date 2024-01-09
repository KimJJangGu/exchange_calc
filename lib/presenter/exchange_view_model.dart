import 'package:exchange_calc/core/result.dart';
import 'package:exchange_calc/domain/model/exchange_model.dart';
import 'package:exchange_calc/domain/use_case/exchange_use_case.dart';
import 'package:exchange_calc/presenter/exchange_state.dart';
import 'package:flutter/material.dart';

class ExchangeViewModel extends ChangeNotifier {
  final ExchangeUseCase _exchangeUseCase;

  ExchangeViewModel({required ExchangeUseCase exchangeUseCase}) : _exchangeUseCase = exchangeUseCase;

  ExchangeState _state = const ExchangeState();

  ExchangeState get state => _state;

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

  
}