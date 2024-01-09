import 'package:exchange_calc/data/dto/exchange_dto.dart';
import 'package:exchange_calc/domain/model/exchange_model.dart';

extension ExchangeMapper on ExchangeDto {
  ExchangeModel toExchangeModel() {
    return ExchangeModel(
      exchangeRates: rates != null ? _toDouble(rates!) : <String, num>{},
      lastUpdateTime: DateTime.fromMillisecondsSinceEpoch(timeLastUpdateUnix?.toInt() ?? 0),
      nextUpdateTime: DateTime.fromMillisecondsSinceEpoch(timeLastUpdateUnix?.toInt() ?? 0),
    );
  }

  Map<String, num> _toDouble(Map<String, dynamic> data) {
    Map<String, num> newMap = {};
    for (var element in data.entries) {
      newMap.putIfAbsent(element.key, () => element.value as num);
    }
    return newMap;
  }
}