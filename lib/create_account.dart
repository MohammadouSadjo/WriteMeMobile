import 'package:flutter/material.dart';
import 'package:write_me/email_validation.dart';
import 'package:write_me/login.dart';
import 'package:intl/intl.dart';

import 'home.dart';

void main() {
  runApp(const CreateAccount());
}

class CreateAccount extends StatelessWidget {
  const CreateAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'RobotoSerif'),
      home: const Account(),
    );
  }
}

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  _Account createState() => _Account();
}

class _Account extends State<Account> {
  TextEditingController dateInput = TextEditingController();

  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
    super.initState();
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
                      'New Account',
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
              padding: EdgeInsets.symmetric(horizontal: 60),
              child: TextField(
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  //border: OutlineInputBorder(),
                  labelText: 'Pseudo',
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                  hintText: 'Enter valid pseudo',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            const Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding:
                  EdgeInsets.only(left: 60.0, right: 60.0, top: 15, bottom: 0),
              child: TextField(
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  //border: OutlineInputBorder(),
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                  hintText: 'Enter valid email',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            const Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding:
                  EdgeInsets.only(left: 60.0, right: 60.0, top: 15, bottom: 0),
              child: TextField(
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  //border: OutlineInputBorder(),
                  labelText: 'Telephone',
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                  hintText: 'Enter valid phone number',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            const Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding:
                  EdgeInsets.only(left: 60.0, right: 60.0, top: 15, bottom: 0),
              child: TextField(
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  //border: OutlineInputBorder(),
                  labelText: 'Name',
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                  hintText: 'Enter your name',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            const Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding:
                  EdgeInsets.only(left: 60.0, right: 60.0, top: 15, bottom: 0),
              child: TextField(
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  //border: OutlineInputBorder(),
                  labelText: 'Surname',
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                  hintText: 'Enter your surname',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.only(
                  left: 60.0, right: 60.0, top: 15, bottom: 0),
              child: TextField(
                style: const TextStyle(
                  color: Colors.white,
                ),
                controller: dateInput,
                //editing controller of this TextField
                decoration: const InputDecoration(
                  //border: OutlineInputBorder(),
                  //icon: Icon(Icons.calendar_today), //icon of text field
                  labelText: "Enter Date",
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ), //label text of field
                ),
                readOnly: true,
                //set it true, so that user will not able to edit text
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2100));

                  if (pickedDate != null) {
                    //print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    //print(formattedDate); //formatted date output using intl package =>  2021-03-16
                    setState(() {
                      dateInput.text =
                          formattedDate; //set output date to TextField value.
                    });
                  } else {}
                },
              ),
            ),
            const Padding(
              padding:
                  EdgeInsets.only(left: 60.0, right: 60.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                style: TextStyle(
                  color: Colors.white,
                ),
                obscureText: true,
                decoration: InputDecoration(
                  //border: OutlineInputBorder(),
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                  hintText: 'Enter secure password',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            const Padding(
              padding:
                  EdgeInsets.only(left: 60.0, right: 60.0, top: 15, bottom: 60),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                style: TextStyle(
                  color: Colors.white,
                ),
                obscureText: true,
                decoration: InputDecoration(
                  //border: OutlineInputBorder(),
                  labelText: 'Password Confirmation',
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                  hintText: 'Enter secure password',
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
                          builder: (_) => const EmailValidation()));
                },
                child: const Text(
                  'Create account',
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
