import 'package:freezed_annotation/freezed_annotation.dart';

part 'exchange_model.freezed.dart';

part 'exchange_model.g.dart';

@freezed
class ExchangeModel with _$ExchangeModel {
  const factory ExchangeModel({
    required Map<String, num> exchangeRates,
    required DateTime lastUpdateTime,
    required DateTime nextUpdateTime,
  }) = _ExchangeModel;

  factory ExchangeModel.fromJson(Map<String, Object?> json) => _$ExchangeModelFromJson(json);
}