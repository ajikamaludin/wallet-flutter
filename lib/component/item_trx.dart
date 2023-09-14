import 'package:flutter/material.dart';
import 'package:wallet/db/database.dart';

class ItemTrx extends StatelessWidget {
  final Transaction trx;

  const ItemTrx({super.key, required this.trx});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  trx.formatAmount,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Text(
                  trx.humanDate,
                  textAlign: TextAlign.end,
                ),
              )
            ],
          ),
          Text(
            trx.description,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
