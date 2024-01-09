import 'package:exchange_calc/domain/model/exchange_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'exchange_state.freezed.dart';

part 'exchange_state.g.dart';

@freezed
class ExchagneState with _$ExchangeState {
  const factory ExchagneState({
    required ExchangeModel exchangeModel,
    @Default(false) bool isLoading,
  }) = _ExchagneState;

  factory ExchagneState.fromJson(Map<String, Object?> json) => _$ExchagneState.FromJson(json);
}
