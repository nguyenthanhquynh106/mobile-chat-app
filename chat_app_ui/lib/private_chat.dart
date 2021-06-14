import 'package:chat_app_ui/main.dart';
import 'package:emoji_picker/emoji_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrivateChat extends StatefulWidget {
  String text;
  PrivateChat({Key key, @required this.text}) : super(key: key);

  @override
  _PrivateChatState createState() => _PrivateChatState();
}

class _PrivateChatState extends State<PrivateChat> {
  TextEditingController _inputController = TextEditingController();
  bool showEmojiKeyboard = false;
  String currentUsername;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUsername();
  }

  getCurrentUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      currentUsername = prefs.getString("currentUsername");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          currentUsername == widget.text
              ? "Chat yourself"
              : "Chat with ${widget.text}",
          style: TextStyle(
            color: Colors.blue[900],
            fontSize: 12,
            fontWeight: FontWeight.bold,
            fontFamily: "GoblinOne",
          ),
        ),
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
                  image: image_bg_private_chat,
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.9), BlendMode.dstATop),
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  showEmojiKeyboard == true ? emojiSelect() : Container(),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                              onPressed: () {},
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
