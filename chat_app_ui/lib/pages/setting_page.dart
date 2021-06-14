import 'dart:convert';
import 'dart:io';

import 'package:chat_app_ui/main.dart';
import 'package:chat_app_ui/pages/login_page.dart';
import 'package:chat_app_ui/response/logout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class SettingPage extends StatefulWidget {
  const SettingPage({Key key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

Future<Logout> responseLogout(String userId) async {
  final String apiUrl = "http://10.0.2.2:8080/api/auth/logout";

  final response = await http.post(
    apiUrl,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "userId": userId,
    }),
  );
  if (response.statusCode == 200) {
    final String responseString = response.body;
    return logoutFromJson(responseString);
  }else {
    return null;
  }
}

class _SettingPageState extends State<SettingPage> {
  File _image;
  Future _getImage()async{
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      print("_image: $_image");
    });
  }

  String currentUsername;
  String currentEmail;
  String currentUserId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUsernameEmail();
  }

  getCurrentUsernameEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      currentUsername = prefs.getString("currentUsername");
      currentEmail = prefs.getString("currentEmail");
      currentUserId = prefs.getString("currentUserId");
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: image_bg_setting,
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.5), BlendMode.darken)),
                ),
              ),
              Center(
                child: ListView(
                  children: [
                    SizedBox(height: 20),
                    CircleAvatar(
                      backgroundColor: Colors.orangeAccent,
                      child: Text(
                        currentUsername == null
                            ? ""
                            : "${currentUsername.characters.first.toUpperCase()}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: "GoblinOne",
                        ),
                      ),
                      radius: 50,
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: Text(
                        "$currentUsername",
                        style: TextStyle(
                          color: Colors.pink[200],
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: "GoblinOne",
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Account Information",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: "GoblinOne",
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            width: 1.5,
                            color: Colors.white,
                          ),
                          bottom: BorderSide(width: 1.5, color: Colors.white),
                        ),
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            leading: Container(
                              height: 40, width: 40,
                              child: Image(
                                image: AssetImage("assets/username.png"),
                              ),
                            ),
                            title: Text(
                              "Username",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                fontFamily: "GoblinOne",
                              ),
                            ),
                            subtitle: Text(
                              currentUsername == null? " ": currentUsername,
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: "GoblinOne",
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 80),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    width: 1,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          ListTile(
                            leading: Container(
                              height: 40, width: 40,
                              child: Image(
                                image: AssetImage("assets/email.png"),
                              ),
                            ),
                            title: Text(
                              "Email",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                fontFamily: "GoblinOne",
                              ),
                            ),
                            subtitle: Text(
                              "$currentEmail",
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: "GoblinOne",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          _image == null ? Padding(
                      padding: const EdgeInsets.all(15),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Container(
                          child: Image(
                            image: AssetImage("assets/flower.png"),
                          ),
                        ),
                      ),
                    ) : Padding(
                            padding: const EdgeInsets.all(15),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: Container(
                                child: Image.file(_image),
                                ),
                              ),
                          ),
                          TextButton(
                            onPressed: (){
                              _getImage();
                            },
                            child: Text("Choose Image"),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: TextButton(
                        child: Text(
                          "LOG OUT",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: "GoblinOne",
                          ),
                        ),
                        onPressed: () async{
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                          Logout logout = await responseLogout(currentUserId);
                          Fluttertoast.showToast(
                              msg: logout.message,
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
