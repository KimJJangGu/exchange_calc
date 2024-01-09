import 'package:exchange_calc/data/data_source/exchange_api.dart';
import 'package:exchange_calc/data/data_source/exchange_api_impl.dart';
import 'package:exchange_calc/data/repository/exchange_repository_impl.dart';
import 'package:exchange_calc/domain/repository/exchange_repository.dart';
import 'package:exchange_calc/domain/use_case/calc_exchange_use_case.dart';
import 'package:exchange_calc/domain/use_case/get_exchange_use_case.dart';
import 'package:exchange_calc/presenter/exchange_view_model.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void diSetUp() {
  getIt.registerSingleton<ExchangeApi>(ExchangeApiImpl());
  getIt.registerSingleton<ExchangeRepository>(ExchangeRepositoryImpl(exchangeApi: getIt<ExchangeApi>()));
  getIt.registerSingleton<GetExchangeUseCase>(GetExchangeUseCase(exchangeRepository: getIt<ExchangeRepository>()));
  getIt.registerSingleton<CalcExchangeUseCase>(CalcExchangeUseCase());
  getIt.registerFactory<ExchangeViewModel>(() => ExchangeViewModel(
        calcExchangeUseCase: getIt<CalcExchangeUseCase>(),
        exchangeUseCase: getIt<GetExchangeUseCase>(),
      ));
}
