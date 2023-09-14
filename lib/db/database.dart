import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

class Transaction {
  int id;
  int amount;
  String description;
  int isExpense;
  String createdAt;

  Transaction(
      {required this.id,
      required this.amount,
      required this.description,
      required this.isExpense,
      required this.createdAt});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'description': description,
      'is_expense': isExpense,
      'createdAt': createdAt,
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
        id: map['id'],
        amount: map['amount'],
        description: map['description'],
        isExpense: map['is_expense'],
        createdAt: map['createdAt']);
  }

  String get humanDate {
    DateTime dateTime = DateTime.parse(createdAt);
    String formattedDate = DateFormat('dd MMMM yyyy').format(dateTime);
    return formattedDate;
  }

  String get formatAmount {
    String famount = NumberFormat.currency(locale: "id").format(amount);
    if (isExpense == 1) {
      famount = '- $famount';
    }
    return famount;
  }
}

class DatabaseHelper {
  static Future<void> createTables(Database db) async {
    await db.execute('''
      CREATE TABLE trx(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        amount NUMERIC,
        description TEXT,
        is_expense INTEGER,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        )
''');
  }

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get db async => _database ??= await _initDatabase();

  static Future<Database> _initDatabase() async {
    return openDatabase(
      'wallet.sqlite',
      version: 1,
      onCreate: (db, version) async {
        await createTables(db);
      },
    );
  }

  Future<int> createItem(String amount, String description, num type) async {
    final db = await instance.db;
    final id = await db.insert('trx',
        {'amount': amount, 'description': description, 'is_expense': type},
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  Future<int> updateItem(
      int id, String amount, String description, num type) async {
    final db = await instance.db;
    await db.update('trx',
        {'amount': amount, 'description': description, 'is_expense': type},
        where: 'id = $id', conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  Future<int> deleteItem(int id) async {
    final db = await instance.db;
    await db.delete('trx', where: 'id = $id');
    return id;
  }

  Future<List<Transaction>> getItems() async {
    final db = await instance.db;
    var trx = await db.query('trx', orderBy: 'createdAt DESC');
    List<Transaction> trxList =
        trx.isNotEmpty ? trx.map((c) => Transaction.fromMap(c)).toList() : [];
    return trxList;
  }

  Future<int> countItems() async {
    final db = await instance.db;
    final result = await db.query('trx');

    return result.length;
  }

  Future<int> getTotalIncome() async {
    int amount = 0;
    final db = await instance.db;
    final r = await db
        .rawQuery('SELECT SUM(amount) as amount FROM trx WHERE is_expense = 0');

    final m = int.tryParse(r[0]['amount'].toString());
    if (m != null) {
      amount += m;
    }

    return amount;
  }

  Future<int> getTotalExpense() async {
    int amount = 0;
    final db = await instance.db;
    final r = await db
        .rawQuery('SELECT SUM(amount) as amount FROM trx WHERE is_expense = 1');

    final m = int.tryParse(r[0]['amount'].toString());
    if (m != null) {
      amount += m;
    }

    return amount;
  }

  Future<int> getBalance() async {
    final income = await instance.getTotalIncome();
    final expense = await instance.getTotalExpense();

    return income - expense;
  }
}
