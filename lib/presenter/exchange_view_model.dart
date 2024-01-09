import 'package:exchange_calc/domain/model/exchange_model.dart';
import 'package:exchange_calc/domain/use_case/exchange_use_case.dart';
import 'package:exchange_calc/presenter/exchange_state.dart';

class ExchangeViewModel {
  final ExchangeUseCase _exchangeUseCase;

  ExchangeViewModel({required ExchangeUseCase exchangeUseCase}) : _exchangeUseCase = exchangeUseCase;

  ExchangeState _state = ExchangeState();
  ExchangeState get state => _state;


}
