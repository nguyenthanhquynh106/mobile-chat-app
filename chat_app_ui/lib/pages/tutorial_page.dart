import 'package:chat_app_ui/pages/chat_page.dart';
import 'package:chat_app_ui/pages/display_all_user.dart';
import 'package:chat_app_ui/pages/setting_page.dart';
import 'package:flutter/material.dart';

class TutorialPage extends StatefulWidget {
  @override
  _TutorialPageState createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  int _selectedPage = 0;
  final _pageOption = [
    DisplayAllUser(),
    ChatPage(),
    Text('Item 3'),
    SettingPage(),
    Text('Item 5'),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _pageOption[_selectedPage],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.green,
          currentIndex: _selectedPage,
          onTap: (int index){
            setState(() {
              _selectedPage = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: "Users",
              backgroundColor: Colors.pinkAccent[100],
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.red[400],
              icon: Icon(Icons.messenger),
              label: "Messenger",
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.orange,
              icon: Icon(Icons.add,
                size: 50,
              ),
              label: "Add",
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.grey,
              icon: Icon(Icons.settings),
              label: "Setting",
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.blue[300],
              icon: Icon(Icons.videogame_asset),
              label: "Game",
            ),
          ],
        ),
      ),
    );
  }
}



