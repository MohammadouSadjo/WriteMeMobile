import 'package:flutter/material.dart';
import 'package:write_me/login.dart';
import 'package:intl/intl.dart';

import 'home.dart';

void main() {
  runApp(const EmailValidation());
}

class EmailValidation extends StatelessWidget {
  const EmailValidation({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'RobotoSerif'),
      home: const ValidEmail(),
    );
  }
}

class ValidEmail extends StatefulWidget {
  const ValidEmail({super.key});

  @override
  _ValidEmail createState() => _ValidEmail();
}

class _ValidEmail extends State<ValidEmail> {
  _EmailConfirm(context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: const Color.fromRGBO(240, 240, 240, 1),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              constraints: const BoxConstraints(maxHeight: 250),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        'Email Confirmed',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 25.0,
                          color: Color.fromRGBO(61, 110, 201, 1.0),
                        ),
                      ),
                    ),
                    const Center(
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 50,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 30, bottom: 30),
                      child: Center(
                        child: Text(
                          'You will be redirected to Login page',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(61, 110, 201, 1.0),
                            borderRadius: BorderRadius.circular(20)),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const Login(),
                              ),
                              (Route<dynamic> route) => false,
                            );
                          },
                          child: const Text(
                            'OK',
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

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
                      'Email Validation',
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
                  _EmailConfirm(context);
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
