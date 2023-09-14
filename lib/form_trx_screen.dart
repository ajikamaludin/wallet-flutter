import 'package:flutter/material.dart';
import 'package:wallet/db/database.dart';

const List<String> types = ['Income', 'Expense'];

class FormTrxScreen extends StatefulWidget {
  final Transaction? trx;
  const FormTrxScreen({Key? key, this.trx}) : super(key: key);

  @override
  State<FormTrxScreen> createState() => _FormTrxScreenState();
}

class _FormTrxScreenState extends State<FormTrxScreen> {
  final amountController = TextEditingController();
  final descController = TextEditingController();

  String _isExpense = 'Expense';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Transactions'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Amount',
                      labelText: 'Amount',
                      border: OutlineInputBorder(),
                    )),
                const SizedBox(height: 20),
                TextField(
                  maxLines: 2,
                  minLines: 2,
                  decoration: const InputDecoration(
                    hintText: 'Description',
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                    hintMaxLines: 3,
                  ),
                  controller: descController,
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                  value: _isExpense,
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      _isExpense = value!;
                    });
                  },
                  items: types.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _addItem();
                      },
                      style: const ButtonStyle(
                        minimumSize: MaterialStatePropertyAll(Size(100, 45)),
                      ),
                      child: const Text(
                        'save',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // HANDLE HERE DELETE
                      },
                      style: ButtonStyle(
                        minimumSize:
                            const MaterialStatePropertyAll(Size(100, 45)),
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.red.shade400),
                      ),
                      child: const Text(
                        'Delete',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    amountController.dispose();
    descController.dispose();
    super.dispose();
  }

  void _addItem() {
    if (amountController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            icon: const Icon(Icons.warning),
            content: const Text(
              'Amount required',
              textAlign: TextAlign.center,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, 'Ok'),
                child: const Text(
                  'Ok',
                ),
              ),
            ],
          );
        },
      );
      return;
    }

    DatabaseSQLite.createItem(amountController.text, descController.text,
            _isExpense == 'Income' ? 0 : 1)
        .then((value) => Navigator.of(context).pop())
        .whenComplete(() => ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('transaction saved'))));
  }
}
