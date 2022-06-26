// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/auth/login_response.dart';
import 'package:todo_app/model/usersModel.dart';
import 'package:todo_app/ui/todo_screen.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

enum LoginStatus { notSignIn, signIn }

class _LoginPageState extends State<LoginPage> implements LoginCallBack {
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  late BuildContext _context;
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  late String _username, _password;

  late LoginResponse _response;

  _LoginPageState() {
    _response = new LoginResponse(this);
  }

  void _submit() {
    final form = formKey.currentState;

    if (form!.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        _response.doLogin(_username, _password);
      });
    }
  }

  void showSnackbar(String text) {
    scaffoldKey.currentState!
        .showSnackBar(new SnackBar(content: new Text(text)));
  }

  var value;
  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      value = sharedPreferences.getInt("value");

      _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
    });
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", 0);
      preferences.commit();
      _loginStatus = LoginStatus.notSignIn;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        _context = context;
        var loginBtn = new RaisedButton(
          onPressed: _submit,
          child: const Text("Login"),
        );
        var loginForm = Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextFormField(
                      onSaved: (val) => _username = val!,
                      decoration: InputDecoration(labelText: "Username"),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextFormField(
                      onSaved: (newValue) => _password = newValue!,
                      decoration: InputDecoration(
                        labelText: "Password",
                      ),
                    ),
                  )
                ],
              ),
            ),
            loginBtn
          ],
        );

        return Scaffold(
          appBar: AppBar(
            title: Text("Login"),
          ),
          key: scaffoldKey,
          body: Container(
            child: new Center(
              child: loginForm,
            ),
          ),
        );

        break;
      case LoginStatus.signIn:
        return TodoScreen();
        break;
    }
  }

  savePref(int value, String user, String pass) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", value);
      preferences.setString("user", user);
      preferences.setString("pass", pass);
      preferences.commit();
    });
  }

  @override
  void onLoginError(String error) {
    showSnackbar(error);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onLoginSuccess(UsersModel user) {
    if (user != null) {
      savePref(1, user.username!, user.password!);
      _loginStatus = LoginStatus.signIn;
    } else {
      showSnackbar("Login Gagal");
      setState(() {
        _isLoading = false;
      });
    }
  }
}
