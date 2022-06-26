import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();

  Database? _database;
  static const String DatabaseName = 'flutter_todo_app.db';
  static const String TableTodo = 'todos';
  static const String TableUser = 'users';

  static const String UserId = 'id';
  static const String UserEmail = 'email';
  static const String UserPassword = 'password';

  static const String TodoId = 'id';
  static const String TodoDesc = 'desc';
  static const String TodoDate = 'due_date';
  static const String TodoIsDone = 'is_done';
  static const String TodoUser = 'user_id';

  Future<Database> get databaseTodo async {
    if (_database != null) {
      return _database!;
    }
    _database = await createDatabase();
    return _database!;
  }

  Future<Database> createDatabase() async {
    Directory documentDir = await getApplicationDocumentsDirectory();
    String path = join(documentDir.path, DatabaseName);

    var openDb = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
            "CREATE TABLE '$TableTodo' ( '$TodoId' INTEGER PRIMARY KEY AUTOINCREMENT, '$TodoDesc' TEXT, '$TodoDate' TEXT, '$TodoIsDone' INTEGER, '$TodoUser' INTEGER )");
        await db.execute(
            "CREATE TABLE '$TableUser' ( '$UserId' INTEGER PRIMARY KEY AUTOINCREMENT, '$UserEmail' TEXT UNIQUE, '$UserPassword' TEXT )");
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) {
        if (newVersion > oldVersion) {}
      },
    );

    return openDb;
  }
}
