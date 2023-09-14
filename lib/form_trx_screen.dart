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

  String _isExpense = types[1];
  String? _errorAmount;

  @override
  void initState() {
    super.initState();
    if (widget.trx != null) {
      amountController.text = '${widget.trx!.amount}';
      descController.text = widget.trx!.description;
      _isExpense = widget.trx!.isExpense == 1 ? types[1] : types[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Transaction'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Amount',
                      labelText: 'Amount',
                      border: const OutlineInputBorder(),
                      errorText: _errorAmount,
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
                  mainAxisAlignment: widget.trx == null
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: onSaveHandle,
                      style: const ButtonStyle(
                        minimumSize: MaterialStatePropertyAll(Size(100, 45)),
                      ),
                      child: const Text(
                        'Save',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    widget.trx != null
                        ? ElevatedButton(
                            onPressed: handleDelete,
                            style: ButtonStyle(
                              minimumSize:
                                  const MaterialStatePropertyAll(Size(100, 45)),
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.red.shade400),
                            ),
                            child: const Text(
                              'Delete',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          )
                        : const Center(),
                  ],
                )
              ],
            ),
          ),
        ));
  }

  void handleDelete() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm'),
          content: const Text('Are you sure want delete ?'),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cencel');
                _deleteItem();
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'Ok'),
              child: const Text('Cencel'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    amountController.dispose();
    descController.dispose();
    super.dispose();
  }

  void onSaveHandle() {
    if (amountController.text.isEmpty) {
      setState(() {
        _errorAmount = 'amount required';
      });
      return;
    }
    if (widget.trx != null) {
      _updateItem();
      return;
    }
    _addItem();
  }

  void _addItem() {
    DatabaseHelper.instance
        .createItem(amountController.text, descController.text,
            _isExpense == 'Income' ? 0 : 1)
        .then((value) => Navigator.of(context).pop(true))
        .whenComplete(() => ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('transaction saved'))));
  }

  void _updateItem() {
    DatabaseHelper.instance
        .updateItem(widget.trx!.id, amountController.text, descController.text,
            _isExpense == types[0] ? 0 : 1)
        .then((value) => Navigator.of(context).pop(true))
        .whenComplete(() => ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('transaction saved'))));
  }

  void _deleteItem() {
    DatabaseHelper.instance
        .deleteItem(widget.trx!.id)
        .then((value) => Navigator.of(context).pop(true))
        .whenComplete(() => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('transaction deleted'))));
  }
}
