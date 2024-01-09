import 'package:exchange_calc/di/di_setup.dart';
import 'package:exchange_calc/presenter/exchange_screen.dart';
import 'package:exchange_calc/presenter/exchange_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

final routes = GoRouter(
  initialLocation: '/',
    routes: [
        GoRoute(
            path: '/',
            builder: (_, __) => ChangeNotifierProvider(
                create: (context) => getIt<ExchangeViewModel>(),
                child: const ExchangeScreen(),
            ),
        )
    ]);