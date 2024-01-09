import '../../core/result.dart';

abstract interface class ExchangeApi {
  Future<Result<Map<String, dynamic>>> fetchExchangeApi();
}