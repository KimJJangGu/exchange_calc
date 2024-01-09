import 'package:exchange_calc/data/dto/exchange_dto.dart';
import 'package:exchange_calc/domain/model/exchange_model.dart';

extension ExchangeMapper on ExchangeDto {
  ExchangeModel toExchangeModel() {
    return ExchangeModel(
      exchangeRates: rates ?? {},
      lastUpdateTime: DateTime.fromMillisecondsSinceEpoch(timeLastUpdateUnix?.toInt() ?? 0),
      nextUpdateTime: DateTime.fromMillisecondsSinceEpoch(timeLastUpdateUnix?.toInt() ?? 0),
    );
  }
}