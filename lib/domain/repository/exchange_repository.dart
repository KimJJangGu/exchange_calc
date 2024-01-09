import 'package:exchange_calc/core/result.dart';
import 'package:exchange_calc/domain/model/exchange_model.dart';

abstract interface class ExchangeRepository {
  Future<Result<ExchangeModel>> getExchangeData();
}