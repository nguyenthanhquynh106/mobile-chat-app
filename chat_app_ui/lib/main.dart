import 'package:chat_app_ui/pages/login_page.dart';
import 'package:flutter/material.dart';

var image_bg_login = AssetImage("assets/bg_login.jpg");
var image_bg_register = AssetImage("assets/bg_register.jpg");
var image_bg_mess = AssetImage("assets/bg_mess.png");
var image_bg_forgot_password = AssetImage("assets/bg_forgot_password.jpg");
var image_bg_choose_group_chat = AssetImage("assets/bg_choose_group_chat.jpg");
var image_bg_all_user = AssetImage("assets/bg_all_user.jpg");
var image_bg_private_chat = AssetImage("assets/bg_private_chat.jpg");
var image_bg_setting = AssetImage("assets/bg_setting.jpg");

void main(){
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    precacheImage(image_bg_login, context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
