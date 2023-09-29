import 'package:flutter/material.dart';
import 'package:write_me/database_helper.dart';
import 'package:write_me/folder_contain.dart';
import 'package:write_me/models/type_note.dart';

import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'home.dart';
// ignore: import_of_legacy_library_into_null_safe

/*void main() {
  runApp(const FolderContainEmpty());
}*/

class FolderContainEmpty extends StatelessWidget {
  const FolderContainEmpty({
    super.key,
    required this.id,
    required this.title,
  });

  final int id;
  final String title;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MyFolderContainEmpty(
      id: id,
      title: title,
    );
    /*MaterialApp(
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
        home: const MyFolderContain(
          title: "WriteMe",
        ));*/
  }
}

class MyFolderContainEmpty extends StatefulWidget {
  const MyFolderContainEmpty(
      {super.key, required this.title, required this.id});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final int id;

  @override
  State<MyFolderContainEmpty> createState() => _MyFolderContainEmptyState();
}

class MyListTile extends StatelessWidget {
  final DateTime dateCreation;
  final DateTime dateModification;
  final String titre;
  final String texte;

  const MyListTile(
      {super.key,
      required this.dateCreation,
      required this.dateModification,
      required this.titre,
      required this.texte});

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    final DateTime now = DateTime.now();
    //DateTime dateInMarch = DateTime(now.year, DateTime.march, now.day);
    String formattedDate =
        DateFormat("dd MMM", 'fr_FR').format(dateModification);
    String formattedDateYear =
        DateFormat("y", 'fr_FR').format(dateModification);

    String dateTime = formattedDate + "\n" + formattedDateYear;

    String formattedTime =
        DateFormat('HH:mm', 'fr_FR').format(dateModification);
    String truncatedText = "";
    if (texte.length > 60) {
      truncatedText = texte.substring(0, 60);
      truncatedText += "...";
      // Faites quelque chose avec truncatedText, par exemple, l'afficher ou le manipuler.
    } else {
      truncatedText = texte;
    }

    //print(dateTime);

    return ListTile(
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            //"20 mars \n2023",
            dateTime,
            textAlign: TextAlign.center,
            style: const TextStyle(
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
        children: [
          Text(
            //"23:27",
            formattedTime,
            style: const TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 10,
            ),
          ),
          Text(
            titre,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          ),
        ],
      ),
      subtitle: Text(
        truncatedText,
        style: const TextStyle(
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
            const PopupMenuItem<String>(
              value: 'edit',
              child: Row(
                children: <Widget>[
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
            const PopupMenuItem<String>(
              value: 'delete',
              child: Row(
                children: <Widget>[
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

class _MyFolderContainEmptyState extends State<MyFolderContainEmpty> {
  late Future<List<Map<String, dynamic>>> type_note;

  late Future<List<Map<String, dynamic>>> _notes;

  @override
  void initState() {
    super.initState();
    // Appelez votre fonction de récupération de données ici, par exemple :
    fetchTypeNote();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    _notes = DatabaseHelper.getNoteByType(widget.id);
  }

  Future<void> fetchTypeNote() async {
    final id = widget.id;
    final results = DatabaseHelper.getTypeNote(id);

    // Maintenant, vous avez les résultats dans la variable "results".
    // Vous pouvez les traiter comme vous le souhaitez.

    type_note = results;

    /*setState(() {
        type_note = Type_Note.fromMap(
            map); // Initialisez "type_note" à l'intérieur de setState.
      });*/ // Remplacez "yourColumnName" par le nom de la colonne dans votre table.
    // Faites quelque chose avec "typeNote".
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => const MyApp(),
            ),
            (Route<dynamic> route) => false,
          ),
        ),
        title: FutureBuilder<List<Map<String, dynamic>>>(
          future: type_note,
          builder: (context, snapshot) {
            final typeNote = snapshot.data;
            return Text(typeNote?[0]["intitule_type"]);
          },
        ),
        actions: [
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'edit',
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.edit,
                        color: Color.fromRGBO(16, 43, 64, 1),
                      ),
                      Text(
                        '  Renommer',
                        style: TextStyle(
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'delete',
                  child: Row(
                    children: <Widget>[
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
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MyApp(),
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
      body: WillPopScope(
        onWillPop: () async {
          // Mettez ici la logique pour contrôler où l'utilisateur sera dirigé
          // lorsque le bouton retour est pressé.
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => const MyApp(),
            ),
            (Route<dynamic> route) => false,
          );
          // Si vous voulez empêcher le retour, retournez false.
          // Sinon, retournez true pour permettre le retour par défaut.
          return true; // ou false selon votre logique
        },
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _notes,
          builder: (context, notesSnapshot) {
            if ((notesSnapshot.connectionState == ConnectionState.waiting) ||
                (notesSnapshot.hasError)) {
              return const Center(child: CircularProgressIndicator());
            } else if ((notesSnapshot.hasData && notesSnapshot.data!.isEmpty)) {
              return Center(
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
                        color: Colors.grey,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 15.0),
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
              );
            } else {
              // Le reste du code pour afficher la liste des dossiers et des notes
              // ...
              initializeDateFormatting();
              return Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
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
                        SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                    Expanded(
                      child: FutureBuilder<List<Map<String, dynamic>>>(
                        future: _notes,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Erreur: ${snapshot.error}');
                          } else if (notesSnapshot.hasData &&
                              notesSnapshot.data!.isEmpty) {
                            return const Text("Aucune note");
                          } else {
                            return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                final note = snapshot.data![index];
                                return Column(
                                  children: [
                                    MyListTile(
                                      dateCreation:
                                          DateTime.fromMillisecondsSinceEpoch(
                                              note["date_creation"]),
                                      dateModification:
                                          DateTime.fromMillisecondsSinceEpoch(
                                              note["date_modification"]),
                                      titre: note["titre"],
                                      texte: note["texte"],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Divider(
                                      indent: 80,
                                      height: 15,
                                      thickness: 0.7,
                                      color: Color.fromRGBO(16, 43, 64, 0.4),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
          },
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
                        'Ajouter une nouvelle note',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12.0,
                          color: Color.fromRGBO(16, 43, 64, 1),
                        ),
                      ),
                      onTap: () {
                        // Do something
                        //Navigator.pop(context);
                        Navigator.pushReplacementNamed(context, '/notefolder',
                            arguments: {'id': widget.id});
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.file_upload,
                        color: Color.fromRGBO(16, 43, 64, 1),
                      ),
                      title: const Text(
                        'Ajouter une note existante',
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
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
