import 'package:flutter/material.dart';
import 'package:write_me/folder_contain_empty.dart';
import 'package:write_me/login.dart';
import 'package:write_me/note.dart';
import 'package:write_me/parameters.dart';

import 'home_empty.dart';

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
      home: const MyHomePage(title: 'WriteMe'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class MyListTile extends StatelessWidget {
  const MyListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "20 mars \n2023",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: Color.fromRGBO(16, 43, 64, 0.5),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 5),
            height: double.infinity,
            width: 3,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(16, 43, 64, 0.4),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
          ),
        ],
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "23:27",
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 10,
            ),
          ),
          Text(
            "Paramètres du compte",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          ),
        ],
      ),
      subtitle: const Text(
        "Paramètres du compte parametres ...",
        style: TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 12,
        ),
      ),
      onTap: () {
        // Ajoutez le code pour traiter l'option 1 ici.
      },
      trailing: PopupMenuButton<String>(
        itemBuilder: (BuildContext context) {
          return <PopupMenuEntry<String>>[
            PopupMenuItem<String>(
              value: 'edit',
              child: Row(
                children: const <Widget>[
                  Icon(
                    Icons.edit,
                    color: Color.fromRGBO(16, 43, 64, 1),
                  ),
                  Text(
                    '  Modifier',
                    style: TextStyle(
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuItem<String>(
              value: 'delete',
              child: Row(
                children: const <Widget>[
                  Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  Text(
                    '  Supprimer',
                    style: TextStyle(
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
      ),
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.purple,
  ];

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
                              builder: (_) => const MyAppEmpty(),
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
            // Ajoutez autant d'options que nécessaire...
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(
                  Icons.folder,
                  color: Color.fromRGBO(16, 43, 64, 1),
                ),
                Text(
                  " Dossiers",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: colors.map((color) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const FolderContainEmpty(),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            const Icon(
                              Icons.folder_rounded,
                              color: Color.fromRGBO(16, 43, 64, 1),
                              size: 100,
                            ),
                            Container(
                              width: 120.0,
                              height: 30.0,
                              // ignore: unnecessary_const
                              margin: const EdgeInsets.only(
                                  right: 10.0, top: 10.0, bottom: 35),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Text(
                                    "Dossier Numéro",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    "25 mars",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11,
                                      color: Color.fromRGBO(16, 43, 64, 0.5),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
            Row(
              children: const [
                Icon(
                  Icons.description,
                  color: Color.fromRGBO(16, 43, 64, 1),
                ),
                Text(
                  " Notes",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(top: 15.0),
                children: const <Widget>[
                  MyListTile(),
                  Divider(
                    indent: 80,
                    height: 15,
                    thickness: 0.7,
                    color: Color.fromRGBO(16, 43, 64, 0.4),
                  ),
                  MyListTile(),
                  Divider(
                    indent: 80,
                    height: 15,
                    thickness: 0.7,
                    color: Color.fromRGBO(16, 43, 64, 0.4),
                  ),
                  MyListTile(),
                  Divider(
                    indent: 80,
                    height: 15,
                    thickness: 0.7,
                    color: Color.fromRGBO(16, 43, 64, 0.4),
                  ),
                  MyListTile(),
                  Divider(
                    indent: 80,
                    height: 15,
                    thickness: 0.7,
                    color: Color.fromRGBO(16, 43, 64, 0.4),
                  ),
                  MyListTile(),
                  Divider(
                    indent: 80,
                    height: 15,
                    thickness: 0.7,
                    color: Color.fromRGBO(16, 43, 64, 0.4),
                  ),
                  ListTile(),

                  // Ajoutez autant d'options que nécessaire...
                ],
              ),
            ),
          ],
        ),
      ),
      /*Center(child: Column(
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
        ),),*/

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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Note(),
                          ),
                        );
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
