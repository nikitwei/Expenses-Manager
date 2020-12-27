import 'package:TestESB/model/category_model.dart';
import 'package:TestESB/model/model.dart';
import 'package:TestESB/model/transaction_model.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart' as path;

abstract class DB {
  static Database _db;

  static int get _version => 1;

  static Future<void> init() async {
    if (_db != null) {
      return;
    }

    try {
      var databasePath = await getDatabasesPath();
      String _path = path.join(databasePath, 'test3.db');
      _db = await openDatabase(_path, version: _version, onCreate: onCreate);
    } catch (e) {
      print(e);
    }
  }

  static void onCreate(Database db, int version) async {
    try {
      String sqlCreateTableTransaction = """
        CREATE TABLE ${TransactionModel.table}(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        is_income INTEGER,
        transaction_date TEXT,
        category_id INTEGER,
        amount REAL,
        description TEXT
        );
      """;

      String sqlCreateTableProductCategories = """
        CREATE TABLE ${CategoryModel.table}(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          category_name STRING
        );
      """;

      await db.execute(sqlCreateTableTransaction);
      await db.execute(sqlCreateTableProductCategories);
    } catch (e) {
      print(e);
    }
  }

  static Future<List<Map<String, dynamic>>> items(String table) async =>
      _db.query(table);

  static Future<Map<String, dynamic>> item(String table, int id) async =>
      await _db.query(table, where: 'id = ?', whereArgs: [id]).then(
          (value) => (value.length > 0) ? value.first : null);

  static Future<int> insert(String table, Model model) async =>
      await _db.insert(table, model.toMap());

  static Future<int> update(String table, Model model) async => await _db
      .update(table, model.toMap(), where: 'id = ?', whereArgs: [model.id]);

  static Future<int> delete(String table, int id) async =>
      await _db.delete(table, where: 'id = ?', whereArgs: [id]);

  static Future<Batch> batch() async => _db.batch();
}
