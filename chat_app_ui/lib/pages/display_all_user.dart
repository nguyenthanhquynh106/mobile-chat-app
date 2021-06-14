import 'dart:convert';
import 'dart:io';
import 'package:chat_app_ui/main.dart';
import 'package:chat_app_ui/pages/chat_page.dart';
import 'package:chat_app_ui/private_chat.dart';
import 'package:chat_app_ui/response/all_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
String currentToken;

class DisplayAllUser extends StatefulWidget {

  const DisplayAllUser({Key key}) : super(key: key);

  @override
  _DisplayAllUserState createState() => _DisplayAllUserState();
}

List<AllUser> listAll = List<AllUser>();

Future<AllUser> getAllUser() async {

  final String apiUrl = "http://10.0.2.2:8080/api/test/users";
  Map<String, String> headers = {
    HttpHeaders.authorizationHeader: "Bearer $currentToken",
  };

  final response = await http.get(apiUrl, headers: headers);
  if (response.statusCode == 200) {
    final String responseString = response.body;
    listAll = allUserFromJson(responseString);
    return null;
  } else {
    return null;
  }
}

class _DisplayAllUserState extends State<DisplayAllUser> {
  String currentUsername;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUsername();
  }
  getCurrentUsername() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    currentUsername = prefs.getString("currentUsername");
    currentToken = prefs.getString("currentToken");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: image_bg_all_user,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: TextButton(
                      onPressed: () async {
                        await getAllUser();
                        setState(() {});
                      },
                      child: Text(
                        "LOAD USERS",
                        style: TextStyle(
                          color: Colors.pinkAccent[400],
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: "GoblinOne",
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      "Total users (${listAll.length})",
                      style: TextStyle(
                        color: Colors.blue[400],
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: "GoblinOne",
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: listAll.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.fromLTRB(0, 5, 40, 10),
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.8),
                                  blurRadius: 9,
                                  spreadRadius: 5,
                                  offset: Offset(3,6),
                                ),
                              ],
                              gradient: LinearGradient(
                                end: Alignment.bottomLeft,
                                begin: Alignment.topRight,
                                colors: [
                                  Colors.blue[300],
                                  Colors.blue[200],
                                  Colors.pink[100],
                                  Colors.pink[200],
                                ]
                              ),
                              borderRadius: BorderRadius.only(topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
                            ),
                            child: InkWell(
                              splashColor: Colors.white,
                              onTap: (){
                                print("Click ${listAll[index].email}");
                                Navigator.push(context, MaterialPageRoute(builder: (context) => PrivateChat(text: "${listAll[index].username}")));
                              },
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                  AssetImage("assets/fb_user.png"),
                                  radius: 30,
                                ),
                                title: Center(child: listAll[index].username == currentUsername? Text("${listAll[index].username} (Me)", style: TextStyle(fontSize: 25)) : Text("${listAll[index].username}", style: TextStyle(fontSize: 25))),
                                subtitle: Center(child: Text("${listAll[index].email}", style: TextStyle(fontSize: 20))),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
