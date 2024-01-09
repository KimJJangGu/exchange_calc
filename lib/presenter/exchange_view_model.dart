import 'package:exchange_calc/domain/use_case/exchange_use_case.dart';

class ExchangeViewModel {
  final ExchangeUseCase _exchangeUseCase;

  ExchangeViewModel({required ExchangeUseCase exchangeUseCase}) : _exchangeUseCase = exchangeUseCase;


}
