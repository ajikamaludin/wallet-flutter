import 'package:flutter/material.dart';

class ItemTrx extends StatelessWidget {
  const ItemTrx({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: const Duration(seconds: 1),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: InkWell(
              onTap: () {},
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Rp. 10.000',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '14 September 2023',
                          textAlign: TextAlign.end,
                        ),
                      )
                    ],
                  ),
                  Text(
                    'Uang Jajan',
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            )));
  }
}
