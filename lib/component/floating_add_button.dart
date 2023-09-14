import 'package:flutter/material.dart';
import 'package:wallet/form_trx_screen.dart';

class FloatingAddButton extends StatelessWidget {
  final Function? refresh;
  const FloatingAddButton({super.key, this.refresh});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return const FormTrxScreen();
            },
          ));
          if (result != null && refresh != null) {
            refresh!();
          }
        },
        child: const Icon(Icons.add));
  }
}
