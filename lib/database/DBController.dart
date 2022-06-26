import 'package:todo_app/database/db.dart';
import 'package:todo_app/model/todoModel.dart';

class DBController {
  final dbClient = DatabaseProvider.dbProvider;

  Future<int> createTODO(todoModel todo) async {
    final db = await dbClient.databaseTodo;

    var result = db.insert("todoTable", todo.toJson());

    return result;
  }

  Future<List<todoModel>> getAllTodos({List<String>? columns}) async {
    final db = await dbClient.databaseTodo;
    var result = await db.query("todoTable", columns: columns);
    List<todoModel> todos = result.isNotEmpty
        ? result.map((todo) => todoModel.fromJSON(todo)).toList()
        : [];

    return todos;
  }

  Future<int> updateTodo(todoModel todo) async {
    final db = await dbClient.databaseTodo;
    var result = await db.update("todoTable", todo.toJson(),
        where: "id = ?", whereArgs: [todo.id]);

    return result;
  }

  Future<int> deleteTodo(int id) async {
    final db = await dbClient.databaseTodo;
    var result = await db.delete("todoTable", where: 'id = ?', whereArgs: [id]);

    return result;
  }
}
