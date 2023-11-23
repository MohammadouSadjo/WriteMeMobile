import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:splash_view/splash_view.dart';
import 'package:write_me/home.dart';

void main() {
  runApp(const MyAppMain());
}

class MyAppMain extends StatelessWidget {
  const MyAppMain({super.key});

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
          child: SplashView(
            duration: const Duration(seconds: 8),
            logo: Image.asset(
              'lib/images/logov2.png',
            ),
            loadingIndicator: const CircularProgressIndicator(
              color: Color.fromRGBO(61, 110, 201, 1.0),
            ),
            done: Done(const MyApp()),
            backgroundColor: const Color.fromRGBO(240, 240, 240, 1),
            bottomLoading: false,
            showStatusBar: true,
          ),
        ));
  }
}
