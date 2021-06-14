import 'package:chat_app_ui/main.dart';
import 'package:emoji_picker/emoji_picker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String currentUsername;
  List<String> list_mess = List<String>();
  bool showEmojiKeyboard = false;
  TextEditingController _inputController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUsername();
  }

  getCurrentUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    currentUsername = prefs.getString("currentUsername");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[100],
        title: Text(
          "Title",
          style: TextStyle(
            color: Colors.blue[900],
            fontFamily: "GoblinOne",
            fontSize: 15,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  Colors.blue[400],
                  Colors.blue[300],
                  Colors.pink[200],
                  Colors.pink[300],
                ]),
          ),
        ),
      ),
      body: Container(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: image_bg_mess,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: list_mess.length,
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
                                offset: Offset(3, 6),
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
                                ]),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30),
                                bottomRight: Radius.circular(30)),
                          ),
                          child: InkWell(
                            splashColor: Colors.white,
                            onTap: () {
                              print("Click ${list_mess[index]}");
                            },
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/fb_user.png"),
                                radius: 30,
                              ),
                              title: Text(
                                currentUsername,
                                style: TextStyle(
                                  color: Colors.blue[900],
                                  fontFamily: "GoblinOne",
                                  fontSize: 15,
                                ),
                              ),
                              subtitle: Center(
                                child: Text(
                                  "${list_mess[index]}",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "GoblinOne",
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      showEmojiKeyboard == true ? emojiSelect() : Container(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Colors.blue[400],
                                  Colors.blue[300],
                                  Colors.pink[200],
                                  Colors.pink[300],
                                ]),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: _inputController,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blue, width: 1),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      labelText: "Input Message",
                                      labelStyle: TextStyle(
                                        color: Colors.white,
                                      ),
                                      prefixIcon: Container(
                                        width: 50,
                                        child: Icon(
                                          Icons.input,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.emoji_emotions,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      showEmojiKeyboard = !showEmojiKeyboard;
                                    });
                                  },
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.send,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      list_mess.add(_inputController.text);
                                    });
                                    _inputController.clear();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget emojiSelect() {
    return EmojiPicker(
        rows: 4,
        columns: 7,
        onEmojiSelected: (emoji, category) {
          print(emoji);
          setState(() {
            _inputController.text = _inputController.text + emoji.emoji;
          });
        });
  }
}
