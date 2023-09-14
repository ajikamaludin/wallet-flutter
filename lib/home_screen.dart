import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wallet/component/bar_chart.dart';
import 'package:wallet/component/card_amount.dart';
import 'package:wallet/component/floating_add_button.dart';
import 'package:wallet/db/database.dart';
import 'package:wallet/list_trx_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String balance = '';
  String expense = '';
  String income = '';

  List<double> listBar = [0, 0, 0, 0, 0, 0, 0];
  double maxValue = 0;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Wallet',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.teal.shade600,
          actions: [
            IconButton(
                onPressed: () => showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('About'),
                          content: const Text('Wallet App By Aji Kamaludin'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Ok'),
                              child: const Text('Ok'),
                            ),
                          ],
                        );
                      },
                    ),
                icon: const Icon(
                  Icons.info_outline,
                  color: Colors.white,
                ))
          ],
        ),
        floatingActionButton: FloatingAddButton(
          refresh: _refresh,
        ),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                child: CardAmount(
                  title: 'Balance',
                  amount: balance,
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
                      amount: income,
                      color: Colors.green.shade400,
                    )),
                    Expanded(
                        child: CardAmount(
                      title: 'Expense',
                      amount: expense,
                      color: Colors.red.shade400,
                    ))
                  ],
                )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: TrxBarChart(
                list: listBar,
                max: maxValue,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: OutlinedButton(
                  onPressed: () async {
                    final result =
                        await Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return const ListTrxScreen();
                      },
                    ));
                    if (result != null) {
                      _refresh();
                    }
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('History Transaction'),
                      Icon(Icons.arrow_forward)
                    ],
                  )),
            ),
          ],
        )));
  }

  void _refresh() {
    DatabaseHelper.instance.getBalance().then((value) {
      setState(() {
        balance = NumberFormat.currency(locale: "id").format(value);
      });
    });
    DatabaseHelper.instance.getTotalIncome().then((value) {
      setState(() {
        income = NumberFormat.currency(locale: "id").format(value);
      });
    });
    DatabaseHelper.instance.getTotalExpense().then((value) {
      setState(() {
        expense = NumberFormat.currency(locale: "id").format(value);
      });
    });
    DatabaseHelper.instance.getItemChart().then((value) {
      setState(() {
        listBar = value;
        maxValue = listBar
            .reduce((max, current) => max > current ? max : current)
            .toDouble();
      });
    });
  }
}
