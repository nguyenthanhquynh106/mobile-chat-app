//import 'dart:html';
import 'dart:convert';
import 'dart:io';

import 'package:chat_app_ui/main.dart';
import 'package:chat_app_ui/pages/login_page.dart';
import 'package:chat_app_ui/user_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

Future<UserModel> registerUser(String username, String email, String password) async {
  final String apiUrl = "http://10.0.2.2:8080/api/auth/signup";

  final response = await http.post(
      apiUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "username": username,
        "email": email,
        "password": password,
      }),
  );
  if(response.statusCode == 400){
    final String responseString = response.body;
    return userModelFromJson(responseString);
  }
  if (response.statusCode == 200) {
    final String responseString = response.body;
    return userModelFromJson(responseString);
  } else {
    return null;
  }
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  UserModel _user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.9),
                  BlendMode.dstATop,
                ),
                image: image_bg_register,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Text(
                    'Register now !',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: "GoblinOne",
                    ),
                  ),
                  Text(
                    'Login to continue using iMess',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                        fontFamily: "GoblinOne"),
                  ),
                  SizedBox(height: 50),
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
                      labelText: 'Username',
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
                    controller: _phoneController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.blue, width: 1),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      labelText: 'Phone',
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      prefixIcon: Container(
                        width: 50,
                        child: Icon(
                          Icons.call,
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
                    controller: _emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.blue, width: 1),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      labelText: "Email",
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      prefixIcon: Container(
                        width: 50,
                        child: Icon(
                          Icons.email,
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
                        borderSide:
                        BorderSide(color: Colors.blue, width: 1),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      labelText: "Password",
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      prefixIcon: Container(
                        width: 50,
                        child: Icon(
                          Icons.lock,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
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

                            ]
                        ),
                        borderRadius: BorderRadius.circular(15)),
                    height: 40,
                    width: 150,
                    //width: double.infinity,
                    child: TextButton(
                      onPressed: () async {
                        if(_usernameController.text==""||_phoneController.text==""||_emailController.text==""||_passController.text==""){
                          Fluttertoast.showToast(
                              msg: "Please fill full information !",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                        }else{
                          final String username = _usernameController.text;
                          final String email = _emailController.text;
                          final String password = _passController.text;
                          final UserModel user = await registerUser(username, email, password);
                          setState(() {
                            _user = user;
                            print(_user.message);
                          });
                          if(_user.message == "Error: Username is already taken!"){
                            Fluttertoast.showToast(
                                msg: "${_user.message}",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                          }
                          if(_user.message == "Error: Email is already in use!"){
                            Fluttertoast.showToast(
                                msg: "${_user.message}",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                          }
                          if(_user.message == "User registered successfully!"){
                            _emailController.clear();_usernameController.clear();_passController.clear();_phoneController.clear();
                            Fluttertoast.showToast(
                                msg: "${_user.message}",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                          }
                          if(_user.message.contains("Validation failed for object='signupRequest'")){
                            Fluttertoast.showToast(
                                msg: "Please check your email !",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                          }
                        }
                      },
                      child: Text(
                        'REGISTER',
                        style: TextStyle(
                          color: Colors.pink,
                          fontFamily: "GoblinOne",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          "Signup with",
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
                          onTap: () {},
                          splashColor: Colors.black,
                          child: CircleAvatar(
                            backgroundImage: AssetImage("assets/logo_gmail2.jpg"),
                            radius: 30,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {},
                          splashColor: Colors.black,
                          child: CircleAvatar(
                            backgroundImage: AssetImage("assets/logo_fb.jpg"),
                            radius: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 9,
                        child: Text(
                          'Already have an Account? ',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: "GoblinOne",
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                          child: Text(
                            'Login now',
                            style: TextStyle(
                                fontFamily: "GoblinOne",
                                fontSize: 12,
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
