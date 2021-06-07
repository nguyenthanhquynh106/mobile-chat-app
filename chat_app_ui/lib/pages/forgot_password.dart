import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Forgot Password',
            style: TextStyle(
              fontFamily: "Satisfy",
              fontSize: 30,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Positioned.fill(
              child: Image(
                image: AssetImage('assets/bg_forgot_password.jpg'),
                fit: BoxFit.fill,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 50),
                  Text(
                    'Forgot password !',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: "GoblinOne",
                    ),
                  ),
                  Text(
                    'Reset password',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                        fontFamily: "GoblinOne"),
                  ),
                  SizedBox(height: 40),
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
                  SizedBox(height: 70),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    height: 40,
                    width: 250,
                    //width: double.infinity,
                    child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'RESET PASSWORD',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "GoblinOne",
                          ),
                        )),
                  ),
                  SizedBox(height: 50),
                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextButton(
                            onPressed: (){},
                            child: Text(
                              "   Verify   ",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "GoblinOne",
                                fontSize: 15,
                              ),
                            ),
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue, width: 1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          labelText: "Verify code",
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          prefixIcon: Container(
                            width: 50,
                            child: Icon(
                              Icons.verified_user_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );;
  }
}
