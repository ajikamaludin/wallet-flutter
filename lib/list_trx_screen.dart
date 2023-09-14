import 'package:flutter/material.dart';
import 'package:wallet/component/floating_add_button.dart';
import 'package:wallet/component/item_trx.dart';
import 'package:wallet/db/database.dart';
import 'package:wallet/form_trx_screen.dart';

class ListTrxScreen extends StatefulWidget {
  const ListTrxScreen({super.key});

  @override
  State<ListTrxScreen> createState() => _ListTrxScreenState();
}

class _ListTrxScreenState extends State<ListTrxScreen> {
  List<Transaction> list = [];

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('History Transaction'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ),
        floatingActionButton: FloatingAddButton(
          refresh: _refresh,
        ),
        body: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: InkWell(
                          onTap: () async {
                            final result = await Navigator.of(context)
                                .push(MaterialPageRoute(
                              builder: (context) {
                                return FormTrxScreen(trx: list[index]);
                              },
                            ));

                            if (result != null) {
                              _refresh();
                            }
                          },
                          child: ItemTrx(
                            trx: list[index],
                          ),
                        ),
                      ),
                      const Divider()
                    ],
                  );
                })));
  }

  void _refresh() {
    DatabaseHelper.instance.getItems().then((value) {
      setState(() {
        list = value;
      });
    });
  }
}
