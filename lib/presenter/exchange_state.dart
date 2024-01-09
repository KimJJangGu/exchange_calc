import 'package:exchange_calc/domain/model/exchange_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'exchange_state.freezed.dart';

part 'exchange_state.g.dart';

@freezed
class ExchangeState with ExchangeState {
  const factory ExchangeState({
    @Default(null) ExchangeModel? exchangeModel,
    @Default(false) bool isLoading,
  }) = ExchangeState;

  factory ExchangeState.fromJson(Map<String, Object?> json) => _$ExchangeStateFromJson(json);
}
