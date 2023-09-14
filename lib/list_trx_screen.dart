import 'package:flutter/material.dart';
import 'package:wallet/component/floating_add_button.dart';
import 'package:wallet/component/item_trx.dart';

class ListTrxScreen extends StatelessWidget {
  const ListTrxScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Riwayat Transaksi'),
        ),
        floatingActionButton: const FloatingAddButton(),
        body: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: 20,
                itemBuilder: (context, index) {
                  return const Column(
                    children: [ItemTrx(), Divider()],
                  );
                })));
  }
}
