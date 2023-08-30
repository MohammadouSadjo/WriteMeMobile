import 'package:flutter/material.dart';
import 'package:write_me/login.dart';
import 'package:write_me/parameters.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'home.dart';
// ignore: import_of_legacy_library_into_null_safe

void main() {
  runApp(const MyAppEmpty());
}

class MyAppEmpty extends StatelessWidget {
  const MyAppEmpty({super.key});

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
        home: const MyHomePageEmpty(
          title: "WriteMe",
        ));
  }
}

class MyHomePageEmpty extends StatefulWidget {
  const MyHomePageEmpty({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePageEmpty> createState() => _MyHomePageEmptyState();
}

class _MyHomePageEmptyState extends State<MyHomePageEmpty> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // afficher une boîte de dialogue avec un TextField
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Center(
                      child: Text(
                        'Recherche',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 25.0,
                          color: Color.fromRGBO(61, 110, 201, 1.0),
                        ),
                      ),
                    ),
                    content: const TextField(
                      decoration: InputDecoration(
                        hintText: 'Rechercher...',
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: const Text(
                          'Annuler',
                          style: TextStyle(
                            color: Color.fromRGBO(61, 110, 201, 1.0),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text(
                          'Rechercher',
                          style: TextStyle(
                            color: Color.fromRGBO(61, 110, 201, 1.0),
                          ),
                        ),
                        onPressed: () {
                          // code à exécuter lorsque l'utilisateur clique sur le bouton Rechercher
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const MyApp(),
                            ),
                            (Route<dynamic> route) => false,
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
        backgroundColor: const Color.fromRGBO(61, 110, 201, 1.0),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              color: const Color.fromRGBO(16, 43, 64, 1),
              height: 100.0,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  height: 50,
                  child: const Center(
                    child: Text("Menu",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.settings,
                color: Color.fromRGBO(16, 43, 64, 1),
              ),
              title: const Text(
                'Paramètres du compte',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyParameters(),
                  ),
                );
                // Ajoutez le code pour traiter l'option 1 ici.
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
                color: Color.fromRGBO(16, 43, 64, 1),
              ),
              title: const Text(
                'Se déonnecter',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const Login(),
                  ),
                  (Route<dynamic> route) => false,
                );
                // Ajoutez le code pour traiter l'option 1 ici.
              },
            ),
            /*ListTile(
              leading: const Icon(Icons.menu),
              title: const Text('Option 2'),
              onTap: () {
                // Ajoutez le code pour traiter l'option 2 ici.
              },
            ),*/
            // Ajoutez autant d'options que nécessaire...
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'lib/images/logov2.png',
              width: 200.0,
              height: 200.0,
            ),
            const Text(
              "Ajouter une note",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 17.0,
                  color: Colors.grey),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
              child: const Center(
                child: Text(
                  "Aucune note n'a encore été créée! Cliquez sur le bouton en bas à droite pour commencer.",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.0,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 150.0,
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(
                        Icons.description,
                        color: Color.fromRGBO(16, 43, 64, 1),
                      ),
                      title: const Text(
                        'Ajouter une note',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12.0,
                          color: Color.fromRGBO(16, 43, 64, 1),
                        ),
                      ),
                      onTap: () {
                        // Do something
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.folder,
                        color: Color.fromRGBO(16, 43, 64, 1),
                      ),
                      title: const Text(
                        'Ajouter un dossier',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12.0,
                          color: Color.fromRGBO(16, 43, 64, 1),
                        ),
                      ),
                      onTap: () {
                        // Do something
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
        tooltip: "Ajout d'une note",
        backgroundColor: const Color.fromRGBO(61, 110, 201, 1.0),
        child: const Icon(Icons.edit),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
