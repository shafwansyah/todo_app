import 'package:todo_app/database/db.dart';
import 'package:todo_app/model/usersModel.dart';

class UsersController {
  final dbClient = DatabaseProvider.dbProvider;

  Future<int> createUser(UsersModel _user) async {
    final db = await dbClient.databaseTodo;
    var result = db.insert("users", _user.toJson());
    return result;
  }

  Future<UsersModel?> getLogin(String user, String password) async {
    final db = await dbClient.databaseTodo;
    var res = await db.rawQuery(
        "SELECT * FROM user WHERE username = '$user' and password = '$password'");

    return new UsersModel.fromJSON(res.first);
  }
}
