import 'package:todo_app/database/UserController.dart';
import 'package:todo_app/model/usersModel.dart';

class RepoUsers {
  final UsersController _dbController = UsersController();

  Future getAllUsers() => _dbController.getAllUsers();
  Future getUser(String email, String pass) =>
      _dbController.getLoginUser(email, pass);
  Future insertTodo(UsersModel _users) => _dbController.createUser(_users);
}
