import 'dart:async';
import 'dart:convert';
import 'package:chat_app_ui/main.dart';
import 'package:chat_app_ui/pages/chat_page.dart';
import 'package:chat_app_ui/pages/display_all_user.dart';
import 'package:chat_app_ui/pages/register_page.dart';
import 'package:chat_app_ui/pages/tutorial_page.dart';
import 'package:chat_app_ui/response/login_fail.dart';
import 'package:chat_app_ui/response/login_success.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

Future<LoginSuccess> responseLoginSuccess(String username, String password) async {
  final String apiUrl = "http://10.0.2.2:8080/api/auth/signin";

  final response = await http.post(
    apiUrl,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "username": username,
      "password": password,
    }),
  );
  if (response.statusCode == 200) {
    final String responseString = response.body;
    return loginSuccessFromJson(responseString);
  }else {
    return null;
  }
}

Future<LoginFail> responseLoginFail(String username, String password) async {
  final String apiUrl = "http://10.0.2.2:8080/api/auth/signin";

  final response = await http.post(
    apiUrl,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "username": username,
      "password": password,
    }),
  );
  if (response.statusCode == 401) {
    final String responseString = response.body;
    return loginFailFromJson(responseString);
  }else {
    return null;
  }
}


class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  LoginFail _fail;
  LoginSuccess _success;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: image_bg_login,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Text(
                      'Welcome back !',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: "GoblinOne",
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      'Login to continue using iMess',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                          fontFamily: "GoblinOne"),
                    ),
                  ),
                  SizedBox(height: 5),
                  TextField(
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    controller: _usernameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      labelText: "Username",
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      prefixIcon: Container(
                        width: 50,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  TextField(
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    obscureText: true,
                    controller: _passController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      labelText: "Password",
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      prefixIcon: Container(
                        width: 50,
                        child: Icon(
                          Icons.lock_outline,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Fluttertoast.showToast(
                          msg: "This feature is currently in development !",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'Forgot password?',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.blue[200],
                            fontFamily: "GoblinOne",
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50),
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [
                              Colors.green[800],
                              Colors.green[600],
                              Colors.green[400],
                              Colors.green[200],
                            ]),
                        borderRadius: BorderRadius.circular(15)),
                    height: 40,
                    width: 150,
                    //width: double.infinity,
                    child: TextButton(
                      onPressed: () async {
                        if (_usernameController.text == "" ||
                            _passController.text == "") {
                          Fluttertoast.showToast(
                              msg: "Please fill full information !",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else {
                          final String username = _usernameController.text;
                          final String password = _passController.text;
                          final LoginSuccess success =
                          await responseLoginSuccess(username, password);
                          LoginFail fail;
                          if(success == null){
                            fail = await responseLoginFail(username, password);
                          }
                          setState(() {
                            _fail = fail;
                            _success = success;
                          });
                          Fluttertoast.showToast(
                              msg: fail==null? "Login Success !":"${_fail.message}",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          if(success != null){
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setString("currentUsername", _usernameController.text);
                            prefs.setString("currentEmail", _success.email);
                            prefs.setString("currentToken", _success.accessToken);
                            prefs.setString("currentUserId", _success.id.toString());
                            _usernameController.clear();
                            _passController.clear();
                            Navigator.push(context, MaterialPageRoute(builder: (context) => TutorialPage()));
                          }
                        }
                      },
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                          color: Colors.pinkAccent,
                          fontFamily: "GoblinOne",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          "Login with",
                          style: TextStyle(
                            fontFamily: "GoblinOne",
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            Fluttertoast.showToast(
                                msg: "This feature is currently in development !",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                          },
                          splashColor: Colors.black,
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/logo_instagram2.jpg"),
                            radius: 30,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            Fluttertoast.showToast(
                                msg: "This feature is currently in development !",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                          },
                          splashColor: Colors.black,
                          child: CircleAvatar(
                            backgroundImage: AssetImage("assets/logo_fb.jpg"),
                            radius: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Text(
                          'New user? ',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: "GoblinOne",
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterPage()));
                          },
                          child: Text(
                            'Sign up for a new account',
                            style: TextStyle(
                                fontFamily: "GoblinOne",
                                fontSize: 13,
                                color: Colors.blue[200]),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
