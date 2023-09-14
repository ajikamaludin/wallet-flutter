import 'package:flutter/material.dart';

class CardAmount extends StatelessWidget {
  final String title;
  final String amount;
  final Color color;
  const CardAmount(
      {super.key,
      required this.title,
      required this.amount,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Column(
            children: [
              Center(
                  child: Text(
                title,
                style: const TextStyle(fontSize: 20, color: Colors.white),
              )),
              Center(
                  child: Text(
                amount,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white),
              )),
            ],
          )),
    );
  }
}
