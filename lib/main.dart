import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:splashscreen/splashscreen.dart';
import 'package:write_me/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          fontFamily: 'RobotoSerif',
          primaryColor: const Color.fromRGBO(61, 110, 201, 1.0),
        ),
        home: Center(
          child: SplashScreen(
            seconds: 8,
            navigateAfterSeconds: const Login(),
            /*title: const Text(
          'WriteMe',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40.0,
            color: Color.fromRGBO(61, 110, 201, 1.0),
          ),
        ),*/
            image: Image.asset(
              'lib/images/logov2.png',
            ),
            photoSize: 200,
            backgroundColor: const Color.fromRGBO(240, 240, 240, 1),
            loaderColor: const Color.fromRGBO(61, 110, 201, 1.0),
            loadingText: const Text('Loading'),
          ),
        ));
  }
}
