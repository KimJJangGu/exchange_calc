import 'package:exchange_calc/core/result.dart';
import 'package:exchange_calc/domain/model/exchange_model.dart';
import 'package:exchange_calc/domain/repository/exchange_repository.dart';

class ExchangeUseCase {
  final ExchangeRepository _exchangeRepository;

  ExchangeUseCase({required ExchangeRepository exchangeRepository})
      : _exchangeRepository = exchangeRepository;

  Future<Result<ExchangeModel>> execute() {
    return _exchangeRepository.getExchangeData();
  }
}
