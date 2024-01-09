import 'package:exchange_calc/core/result.dart';
import 'package:exchange_calc/data/data_source/exchange_api.dart';
import 'package:exchange_calc/data/data_source/exchange_api_impl.dart';
import 'package:exchange_calc/data/dto/exchange_dto.dart';
import 'package:exchange_calc/data/mapper/exchange_mapper.dart';
import 'package:exchange_calc/domain/model/exchange_model.dart';
import 'package:exchange_calc/domain/repository/exchange_repository.dart';

class ExchangeRepositoryImpl implements ExchangeRepository {
  final ExchangeApi _exchangeApi;

  ExchangeRepositoryImpl({required ExchangeApi exchangeApi}) : _exchangeApi = exchangeApi;

  @override
  Future<Result<ExchangeModel>> getExchangeData() async {
    Result<Map<String, dynamic>> result = await _exchangeApi.fetchExchangeApi();

    return result.when(
      success: (data) {
        final ExchangeDto dto = ExchangeDto.fromJson(data);

        return Result.success(dto.toExchangeModel());
      },
      error: (e) => Result.error(e),
    );
  }
}