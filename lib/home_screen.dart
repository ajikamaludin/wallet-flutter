import 'package:flutter/material.dart';
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
  int balance = 0;
  int expense = 0;
  int income = 0;

  @override
  void initState() {
    super.initState();
    DatabaseSQLite.getBalance().then((value) {
      setState(() {
        balance = value;
      });
    });
    DatabaseSQLite.getTotalIncome().then((value) => income = value);
    DatabaseSQLite.getTotalExpense().then((value) => expense = value);
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
        floatingActionButton: const FloatingAddButton(),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                child: CardAmount(
                  title: 'Balance',
                  amount: 'Rp. $balance',
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
                      amount: 'Rp. $income',
                      color: Colors.green.shade400,
                    )),
                    Expanded(
                        child: CardAmount(
                      title: 'Expense',
                      amount: 'Rp. $expense',
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
