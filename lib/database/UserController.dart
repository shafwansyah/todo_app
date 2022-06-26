import 'package:todo_app/database/DatabaseProvider.dart';
import 'package:todo_app/model/usersModel.dart';

class UsersController {
  final dbClient = DatabaseProvider.dbProvider;
  String TableUser = DatabaseProvider.TableUser;
  String UserPassword = DatabaseProvider.UserPassword;
  String UserEmail = DatabaseProvider.UserEmail;

  Future<int> createUser(UsersModel _user) async {
    final db = await dbClient.databaseTodo;
    var result = await db.insert(TableUser, _user.toJson());
    return result;
  }

  Future<List<UsersModel>> getAllUsers({List<String>? columns}) async {
    final db = await dbClient.databaseTodo;
    var result = await db.query(TableUser, columns: columns);
    List<UsersModel> users = result.isNotEmpty
        ? result.map((user) => UsersModel.fromJSON(user)).toList()
        : [];

    return users;
  }

  Future<UsersModel> getLoginUser(String user, String password) async {
    final db = await dbClient.databaseTodo;
    var res = await db.rawQuery("SELECT * FROM $TableUser WHERE "
        "$UserEmail = '$user' AND "
        "$UserPassword = '$password'");

    return new UsersModel.fromJSON(res.first);
  }
}
