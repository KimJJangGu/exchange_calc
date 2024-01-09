import 'package:exchange_calc/presenter/exchange_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExchangeScreen extends StatefulWidget {
  const ExchangeScreen({super.key});

  @override
  State<ExchangeScreen> createState() => _ExchangeScreenState();
}

class _ExchangeScreenState extends State<ExchangeScreen> {
  @override
  void initState() {
    Future.microtask(() {
      final viewModel = context.read<ExchangeViewModel>();
      viewModel.getCurrencyExchange();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ExchangeViewModel>();
    final state = viewModel.state;
    return Scaffold(
      appBar: AppBar(
        title: const Text('환율 계산기'),
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Column(
                children: [
                  Text('갱신 시간 : ${state.exchangeModel?.lastUpdateTime ?? '알수없음'}'),
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(

                    ),
                  )
                ],
              ),
            ),
    );
  }
}
