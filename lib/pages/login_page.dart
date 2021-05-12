import 'package:chat_app_ui/pages/register_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Login',
            style: TextStyle(
              fontFamily: "Satisfy",
              fontSize: 30,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RegisterPage()));
            },
          ),
        ],
      ),
      body: Container(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Positioned.fill(
              child: Image(
                image: AssetImage('assets/bg_login.jpg'),
                fit: BoxFit.fill,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 50),
                  Text(
                    'Welcome back !',
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
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1),
                        borderRadius: BorderRadius.circular(6),
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
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1),
                        borderRadius: BorderRadius.circular(6),
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
                      onPressed: () {},
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
                      )),
                  SizedBox(height: 100),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    height: 40,
                    width: 150,
                    //width: double.infinity,
                    child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "GoblinOne",
                          ),
                        )),
                  ),
                  SizedBox(height: 40),
                  Row(
                    children: [
                      Text(
                        "Login with",
                        style: TextStyle(
                          fontFamily: "GoblinOne",
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 40),
                      InkWell(
                        onTap: () {},
                        splashColor: Colors.black,
                        child: CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/logo_instagram.png"),
                          radius: 30,
                        ),
                      ),
                      SizedBox(width: 5),
                      InkWell(
                        onTap: () {},
                        splashColor: Colors.black,
                        child: CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/logo_fb.jpg"),
                          radius: 30,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'New user? ',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: "GoblinOne",
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Sign up for a new account',
                          style: TextStyle(
                              fontFamily: "GoblinOne",
                              fontSize: 14,
                              color: Colors.blue[200]),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
