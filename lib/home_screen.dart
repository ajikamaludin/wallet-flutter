import 'package:flutter/material.dart';
import 'package:wallet/component/bar_chart.dart';
import 'package:wallet/component/card_amount.dart';
import 'package:wallet/component/floating_add_button.dart';
import 'package:wallet/list_trx_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Wallet',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.teal.shade600,
        ),
        floatingActionButton: const FloatingAddButton(),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                child: CardAmount(
                  title: 'Balance',
                  amount: 'Rp. 10.000',
                  color: Colors.blue.shade400,
                )),
            Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                        child: CardAmount(
                      title: 'Income',
                      amount: 'Rp. 10.000',
                      color: Colors.green.shade400,
                    )),
                    Expanded(
                        child: CardAmount(
                      title: 'Expense',
                      amount: 'Rp. 10.000',
                      color: Colors.red.shade400,
                    ))
                  ],
                )),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TrxBarChart(),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return const ListTrxScreen();
                      },
                    ));
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Riwayat transaksi'),
                      Icon(Icons.arrow_forward)
                    ],
                  )),
            ),
          ],
        )));
  }
}
