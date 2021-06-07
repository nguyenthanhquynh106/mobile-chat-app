import 'dart:io';

import 'package:chat_app_ui/main.dart';
import 'package:chat_app_ui/pages/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
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
                        "Account Infor",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
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
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
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
