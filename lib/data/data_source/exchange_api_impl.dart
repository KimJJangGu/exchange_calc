import 'dart:convert';

import 'package:exchange_calc/core/result.dart';
import 'package:exchange_calc/data/data_source/exchange_api.dart';
import 'package:http/http.dart' as http;

class ExchangeApiImpl implements ExchangeApi {
  @override
  Future<Result<Map<String, dynamic>>> fetchExchangeApi() async {
    try {
      final http.Response response = await http.get(Uri.parse('https://open.er-api.com/v6/latest/KRW'));
      return Result.success(jsonDecode(response.body));
    } catch (e) {
      return Result.error(e.toString());
    }
  }
}

void main() async {
  Result<Map<String, dynamic>> data = await ExchangeApiImpl().fetchExchangeApi();
}
