import 'dart:async';

import 'package:exchange_calc/presenter/exchange_state.dart';
import 'package:exchange_calc/presenter/exchange_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExchangeScreen extends StatefulWidget {
  const ExchangeScreen({super.key});

  @override
  State<ExchangeScreen> createState() => _ExchangeScreenState();
}

class _ExchangeScreenState extends State<ExchangeScreen> {
  TextEditingController srcController = TextEditingController();
  TextEditingController destController = TextEditingController();

  List<StreamSubscription> subscriptions = [];

  @override
  void initState() {
    Future.microtask(() {
      final ExchangeViewModel viewModel = context.read<ExchangeViewModel>();
      viewModel.getCurrencyExchange();

      subscriptions.add(viewModel.srcStream.listen((event) {
        srcController.text = event.toString();
      }));

      subscriptions.add(viewModel.destStream.listen((event) {
        destController.text = event.toString();
      }));
    });

    super.initState();
  }

  @override
  void dispose() {
    for (final ss in subscriptions) {
      ss.cancel();
    }
    srcController.dispose();
    destController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ExchangeViewModel viewModel = context.watch<ExchangeViewModel>();
    final ExchangeState state = viewModel.state;
    return Scaffold(
      appBar: AppBar(
        title: const Text('환율 계산기'),
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : (state.exchangeModel == null)
            ? Center(child: TextButton.icon(onPressed: viewModel.getCurrencyExchange, icon: const Icon(Icons.refresh), label: Text('데이터 오류')),)
            : Center(
              child: Column(
                children: [
                  Text('기준 시간 : ${state.exchangeModel!.lastUpdateTime}'),
                  TextField(
                    controller: srcController,
                    onChanged: viewModel.selectSourceValue,
                    keyboardType: TextInputType.number,
                  ),
                  DropdownButton<String>(
                    value: state.sourceUnit,
                    items: state.exchangeModel!.exchangeRates.keys.map((e) => DropdownMenuItem<String>(value: e, child: Text(e))).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        viewModel.selectSource(value, srcController.text);
                      }
                    },
                  ),
                  const SizedBox(
                    height: 200,
                  ),
                  TextField(
                    controller: destController,
                    onChanged: viewModel.selectDestValue,
                    keyboardType: TextInputType.number,
                  ),
                  DropdownButton<String>(
                    value: state.destUnit,
                    items: state.exchangeModel!.exchangeRates.keys.map((e) => DropdownMenuItem<String>(value: e, child: Text(e))).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        viewModel.selectDest(value, srcController.text);
                      }
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
