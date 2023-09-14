import 'package:flutter/material.dart';
import 'package:wallet/form_trx_screen.dart';

class FloatingAddButton extends StatelessWidget {
  const FloatingAddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return const FormTrxScreen();
            },
          ));
        },
        child: const Icon(Icons.add));
  }
}
