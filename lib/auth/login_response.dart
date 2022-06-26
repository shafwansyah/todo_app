import 'package:todo_app/auth/login_request.dart';
import 'package:todo_app/model/usersModel.dart';

abstract class LoginCallBack {
  void onLoginSuccess(UsersModel user);
  void onLoginError(String error);
}

class LoginResponse {
  LoginCallBack _callBack;
  LoginRequest _loginRequest = new LoginRequest();
  LoginResponse(this._callBack);

  doLogin(String username, String password) {
    _loginRequest
        .getLogin(username, password)
        .then((user) => _callBack.onLoginSuccess(user!))
        .catchError((onError) => _callBack.onLoginError(onError.toString()));
  }
}
