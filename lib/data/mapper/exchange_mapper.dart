import 'package:exchange_calc/data/dto/exchange_dto.dart';
import 'package:exchange_calc/domain/model/exchange_model.dart';

extension ExchangeMapper on ExchangeDto {
  ExchangeModel toExchangeModel() {
    return ExchangeModel(
      exchangeRates: _toConcreteData(rates),
      lastUpdateTime: DateTime.fromMillisecondsSinceEpoch((timeLastUpdateUnix?.toInt() ?? 0) * 1000),
      nextUpdateTime: DateTime.fromMillisecondsSinceEpoch((timeNextUpdateUnix?.toInt() ?? 0) * 1000),
    );
  }

  Map<String, num> _toConcreteData(Map<String, dynamic>? data) {
    if (data == null) {
      return {};
    }

    return Map<String, num>.fromEntries(
        data.entries.map((entry) => MapEntry(entry.key, entry.value as num)));
  }
}