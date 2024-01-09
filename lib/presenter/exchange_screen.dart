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
          : Center(
              child: Column(
                children: [
                  Text('기준 시간 : ${state.exchangeModel?.lastUpdateTime ?? '알수없음'}'),
                  TextField(
                    controller: srcController,
                    onChanged: (value) {
                      viewModel.selectSourceValue(value);
                    },
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
                    onChanged: (value) {
                      viewModel.selectDestValue(value);
                    },
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
