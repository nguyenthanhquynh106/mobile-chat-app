import 'package:chat_app_ui/main.dart';
import 'package:emoji_picker/emoji_picker.dart';
import 'package:flutter/material.dart';


class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool showEmojiKeyboard = false;
  TextEditingController _inputController = TextEditingController();
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
            Container(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  showEmojiKeyboard == true ? emojiSelect() : Container(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5 , horizontal: 10),
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
                                    borderSide:
                                    BorderSide(color: Colors.blue, width: 1),
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
                              onPressed:() {
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
                              onPressed:(){},
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
  Widget emojiSelect(){
    return EmojiPicker(
        rows: 4, columns: 7,
        onEmojiSelected: (emoji, category){
          print(emoji);
          setState(() {
            _inputController.text = _inputController.text + emoji.emoji;
          });
        });
  }
}
