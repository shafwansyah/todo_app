import 'package:flutter/material.dart';
import 'package:todo_app/database/UserController.dart';
import 'package:todo_app/model/usersModel.dart';
import 'package:todo_app/ui/login_page.dart';
import 'package:toast/toast.dart';
import 'package:todo_app/ui/todo_screen.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');
  var userController;

  @override
  void initState() {
    super.initState();
    userController = UsersController();
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    register() async {
      String email = emailController.text;
      String password = passwordController.text;

      print([email, password]);

      if (email.isEmpty) {
        Toast.show("Please enter your email",
            duration: Toast.lengthLong, gravity: Toast.bottom);
      } else if (password.isEmpty) {
        Toast.show("Please enter your password",
            duration: Toast.lengthLong, gravity: Toast.bottom);
      }

      UsersModel usersModel = UsersModel(email: email, password: password);
      await userController.createUser(usersModel).then((userData) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
            (Route<dynamic> route) => false);
      }).catchError((error) {
        print('error');
        Toast.show("Error: Data Save Failed",
            duration: Toast.lengthLong, gravity: Toast.bottom);
      });

      Toast.show("Successfully Registered",
          duration: Toast.lengthLong, gravity: Toast.bottom);
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
                      "Register",
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
                        onPressed: register,
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: EdgeInsets.all(
                              18.0,
                            )),
                        child: Text(
                          'Register',
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
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      (Route<dynamic> route) => false);
                },
                child: Text(
                  'Login',
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
