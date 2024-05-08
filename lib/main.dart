import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splash_view/splash_view.dart';
import 'package:write_me/home.dart';
import 'package:write_me/providers/listNotesProvider.dart';
import 'package:write_me/providers/typeNoteProvider.dart';
import 'package:write_me/utils/constants/colors.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ListNotesProvider()),
        ChangeNotifierProvider(create: (_) => TypeNoteProvider()),
      ],
      child: const MyAppMain(),
    ),
  );
}

class MyAppMain extends StatelessWidget {
  const MyAppMain({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'RobotoSerif',
          primaryColor: Utils.mainColor,
        ),
        home: Center(
          child: SplashView(
            logo: Image.asset(
              'lib/images/logov2.png',
            ),
            loadingIndicator: const CircularProgressIndicator(
              color: Utils.mainColor,
            ),
            done: Done(const MyApp()),
            backgroundColor: Utils.bgColorSplashScreen,
            bottomLoading: false,
            showStatusBar: true,
          ),
        ));
  }
}
