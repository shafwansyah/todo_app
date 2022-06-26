import 'package:todo_app/database/UserController.dart';
import 'package:todo_app/model/usersModel.dart';

class LoginRequest {
  UsersController _usersController = new UsersController();

  Future<UsersModel?> getLogin(String username, String password) {
    var result = _usersController.getLogin(username, password);
    return result;
  }
}
