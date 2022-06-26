import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();

  Database? _database;

  Future<Database> get databaseTodo async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await createDatabase();
      return _database!;
    }
  }

  Future<Database> createDatabase() async {
    Directory documentDir = await getApplicationDocumentsDirectory();

    String path = join(documentDir.path, "flutter_todo_app.db");
    print(path + " <<<<< dbLocation");

    var openDb = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        Batch batch = db.batch();
        batch.execute(
            "CREATE TABLE todoTable ( id INTEGER PRIMARY KEY AUTOINCREMENT, desc TEXT, due_date TEXT, is_done INTEGER, user_id INTEGER )");
        batch.execute(
            "CREATE TABLE users ( id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT, password TEXT )");
        List<dynamic> res = await batch.commit();
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) {
        if (newVersion > oldVersion) {}
      },
    );

    return openDb;
  }
}
