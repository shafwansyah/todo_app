import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:todo_app/blocs/user_bloc.dart';
import 'package:todo_app/database/UserController.dart';
import 'package:todo_app/ui/register_page.dart';
import 'package:todo_app/ui/todo_page.dart';
import 'package:todo_app/ui/todo_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');
  var userController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userController = UsersController();
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    signIn() async {
      String email = emailController.text;
      String password = passwordController.text;

      if (email.isEmpty) {
        Toast.show("Please enter your email",
            duration: Toast.lengthLong, gravity: Toast.bottom);
      } else if (password.isEmpty) {
        Toast.show("Please enter your password",
            duration: Toast.lengthLong, gravity: Toast.bottom);
      }

      await userController.getLoginUser(email, password).then((userData) {
        print(userData);
        if (userData != null) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => TodoListPage()),
              (Route<dynamic> route) => false);
        } else {
          Toast.show("Error: User Not Found",
              duration: Toast.lengthLong, gravity: Toast.bottom);
        }
      }).catchError((error) {
        print(error);
        Toast.show("Error: Login Failed",
            duration: Toast.lengthLong, gravity: Toast.bottom);
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "Login",
                      style: TextStyle(fontSize: 24),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15.0),
                      padding: EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: Colors.black,
                            width: 1,
                            style: BorderStyle.solid),
                      ),
                      child: TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration:
                            InputDecoration.collapsed(hintText: 'Email'),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15.0),
                      padding: EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: Colors.black,
                            width: 1,
                            style: BorderStyle.solid),
                      ),
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration:
                            InputDecoration.collapsed(hintText: 'Pasword'),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      child: TextButton(
                        onPressed: signIn,
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: EdgeInsets.all(
                              18.0,
                            )),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterPage(),
                      ));
                },
                child: Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
