import 'package:flutter/material.dart';

const List<String> types = ['Pemasukan', 'Pengeluaran'];

class FormTrxScreen extends StatefulWidget {
  const FormTrxScreen({super.key});

  @override
  State<FormTrxScreen> createState() => _FormTrxScreenState();
}

class _FormTrxScreenState extends State<FormTrxScreen> {
  // ignore: unused_field
  String _amount = '';
  // ignore: unused_field
  final String _desc = '';
  String _type = 'Pemasukan';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Transaksi'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Write your amount here...',
                    labelText: 'Amount',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (String value) {
                    setState(() {
                      _amount = value;
                    });
                  },
                ),
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
                  onChanged: (String value) {
                    setState(() {
                      _amount = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                  value: _type,
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      _type = value!;
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
                      onPressed: () {},
                      style: const ButtonStyle(
                        minimumSize: MaterialStatePropertyAll(Size(100, 45)),
                      ),
                      child: const Text(
                        'Simpan',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        minimumSize:
                            const MaterialStatePropertyAll(Size(100, 45)),
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.red.shade400),
                      ),
                      child: const Text(
                        'Hapus',
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
}
