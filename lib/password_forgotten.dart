import 'package:flutter/material.dart';
import 'package:write_me/change_password.dart';
import 'package:write_me/login.dart';
import 'package:intl/intl.dart';

import 'home.dart';

void main() {
  runApp(const PasswordForgotten());
}

class PasswordForgotten extends StatelessWidget {
  const PasswordForgotten({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'RobotoSerif'),
      home: const PasswordState(),
    );
  }
}

class PasswordState extends StatefulWidget {
  const PasswordState({super.key});

  @override
  _PasswordState createState() => _PasswordState();
}

class _PasswordState extends State<PasswordState> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(16, 43, 64, 1),
      appBar: AppBar(
        title: const Text("WriteMe"),
        backgroundColor: const Color.fromRGBO(61, 110, 201, 1.0),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                  //width: 200,
                  height: 150,
                  /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                  child: const Center(
                    child: Text(
                      'Password Forgotten',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 30.0,
                        color: Color.fromRGBO(61, 110, 201, 1.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.only(left: 60, right: 60, bottom: 60),
              child: TextField(
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.security,
                    color: Colors.white,
                  ),
                  //border: OutlineInputBorder(),
                  labelText: 'Verification code',
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                  hintText: 'Enter your verification code',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            Container(
              height: 50,
              width: 200,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(61, 110, 201, 1.0),
                  borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ChangePassword(),
                    ),
                  );
                },
                child: const Text(
                  'Send',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            const SizedBox(
              height: 130,
            ),
          ],
        ),
      ),
    );
  }
}
