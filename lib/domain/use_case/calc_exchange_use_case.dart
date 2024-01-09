class CalcExchangeUseCase {
  num execute(String value, num source, num target) {
    num src = num.parse(value);
    num division = source / target;

    return num.parse((src / division).toStringAsFixed(6));
  }
}