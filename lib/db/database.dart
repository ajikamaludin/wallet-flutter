import 'package:sqflite/sqflite.dart' as sql;

class Transaction {
  num amount;
  String description;
  num isExpense;

  Transaction(
      {required this.amount,
      required this.description,
      required this.isExpense});
}

class DatabaseSQLite {
  static Future<void> createTables(sql.Database db) async {
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

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'wallet.sqlite',
      version: 1,
      onCreate: (db, version) async {
        await createTables(db);
      },
    );
  }

  static Future<int> createItem(
      String amount, String description, num type) async {
    final db = await DatabaseSQLite.db();
    final id = await db.insert('trx',
        {'amount': amount, 'description': description, 'is_expense': type},
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await DatabaseSQLite.db();
    return db.query('trx');
  }

  static Future<int> countItems() async {
    final db = await DatabaseSQLite.db();
    final result = await db.query('trx');

    return result.length;
  }

  static Future<int> getTotalIncome() async {
    int amount = 0;
    final db = await DatabaseSQLite.db();
    final result = await db
        .rawQuery('SELECT SUM(amount) as amount FROM trx WHERE is_expense = 1');

    for (var r in result) {
      amount += (int.parse(r['amount'].toString()));
    }

    return amount;
  }

  static Future<int> getTotalExpense() async {
    int amount = 0;
    final db = await DatabaseSQLite.db();
    final result = await db
        .rawQuery('SELECT SUM(amount) as amount FROM trx WHERE is_expense = 0');

    for (var r in result) {
      amount += (int.parse(r['amount'].toString()));
    }

    return amount;
  }

  static Future<int> getBalance() async {
    int amount = 0;
    final db = await DatabaseSQLite.db();
    final result = await db.rawQuery('SELECT SUM(amount) as amount FROM trx');

    for (var r in result) {
      amount += (int.parse(r['amount'].toString()));
    }

    return amount;
  }
}
