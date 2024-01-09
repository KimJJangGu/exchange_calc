class ExchangeModel {
  Map<String, num> exchangeRates;
  DateTime lastUpdateTime;
  DateTime nextUpdateTime;

  ExchangeModel({
    required this.exchangeRates,
    required this.lastUpdateTime,
    required this.nextUpdateTime,
  });
}