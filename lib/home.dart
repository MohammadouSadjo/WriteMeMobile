import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:write_me/folder_contain_empty.dart';
import 'package:write_me/home_research.dart';
import 'package:write_me/models/type_note.dart';
import 'package:write_me/note.dart';
import 'package:write_me/note_folder.dart';
import 'package:write_me/note_print.dart';
import 'package:write_me/note_update.dart';

import 'database_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/note': (context) => const Note(),
        '/notefolder': (context) => const NoteFolder(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'RobotoSerif',
        primaryColor: const Color.fromRGBO(61, 110, 201, 1.0),
      ),
      home: const MyHomePage(title: 'WriteMe'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class MyListTile extends StatelessWidget {
  final int id;
  final DateTime dateCreation;
  final DateTime dateModification;
  final String titre;
  final String texte;

  const MyListTile(
      {super.key,
      required this.id,
      required this.dateCreation,
      required this.dateModification,
      required this.titre,
      required this.texte});

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();

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
    } else {
      truncatedText = texte;
    }

    return ListTile(
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NotePrint(
              id: id,
              dateCreation: dateCreation,
              dateModification: dateModification,
              titre: titre,
              texte: texte,
            ),
          ),
        );
      },
      trailing: PopupMenuButton<String>(
        itemBuilder: (BuildContext context) {
          return <PopupMenuEntry<String>>[
            PopupMenuItem<String>(
              value: 'edit',
              child: const Row(
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
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NoteUpdate(
                      id: id,
                      dateCreation: dateCreation,
                      dateModification: dateModification,
                      titre: titre,
                      texte: texte,
                    ),
                  ),
                );
              },
            ),
            PopupMenuItem<String>(
              value: 'delete',
              child: const Row(
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
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Center(
                        child: Text(
                          'Suppression',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20.0,
                            color: Color.fromRGBO(61, 110, 201, 1.0),
                          ),
                        ),
                      ),
                      content: const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: 10, right: 10, bottom: 15),
                            child: Text(
                              "Etes-vous sûr de vouloir supprimer cette note?",
                              style: TextStyle(
                                color: Color.fromRGBO(16, 43, 64, 1),
                              ),
                            ),
                          ),
                        ],
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
                              'Confirmer',
                              style: TextStyle(
                                color: Color.fromRGBO(61, 110, 201, 1.0),
                              ),
                            ),
                            onPressed: () async {
                              await DatabaseHelper.deleteNote(id);
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const MyApp(),
                                ),
                                (Route<dynamic> route) => false,
                              );
                            }),
                      ],
                    );
                  },
                );
              },
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

  List<Type_Note> dossiers = [];

  late Future<List<Map<String, dynamic>>> _notes;
  late Future<List<Map<String, dynamic>>> _typenotes;

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    _notes = DatabaseHelper.getNotes();
    _typenotes = DatabaseHelper.getTypeNotes();
  }

  Future<List<Map<String, dynamic>>> getTypenotes() async {
    return await DatabaseHelper.getTypeNotes();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController intituletypeController = TextEditingController();
    TextEditingController researchController = TextEditingController();
    FlutterStatusbarcolor.setStatusBarColor(
      const Color.fromRGBO(61, 110, 201, 1.0),
    );

    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
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
                    content: TextField(
                      controller: researchController,
                      decoration: const InputDecoration(
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
                          if (researchController.text == "") {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Center(
                                    child: Text(
                                      'Erreur',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20.0,
                                        color:
                                            Color.fromRGBO(61, 110, 201, 1.0),
                                      ),
                                    ),
                                  ),
                                  content: const Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10, bottom: 15),
                                        child: Text(
                                          'Zone de texte vide!',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15.0,
                                            color: Color.fromRGBO(
                                                61, 110, 201, 1.0),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      child: const Text(
                                        'Fermer',
                                        style: TextStyle(
                                          color:
                                              Color.fromRGBO(61, 110, 201, 1.0),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyAppResearch(
                                  title: 'WriteMe',
                                  research: researchController.text,
                                ),
                              ),
                            );
                          }
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
              child: const Align(
                alignment: Alignment.bottomLeft,
                child: SizedBox(
                  height: 50,
                  child: Center(
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
                Icons.logout,
                color: Color.fromRGBO(16, 43, 64, 1),
              ),
              title: const Text(
                "Fermer l'application",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _typenotes,
        builder: (context, typenotesSnapshot) {
          return FutureBuilder<List<Map<String, dynamic>>>(
            future: _notes,
            builder: (context, notesSnapshot) {
              if ((typenotesSnapshot.connectionState ==
                          ConnectionState.waiting &&
                      notesSnapshot.connectionState ==
                          ConnectionState.waiting) ||
                  (typenotesSnapshot.hasError && notesSnapshot.hasError)) {
                return const Center(child: CircularProgressIndicator());
              } else if ((typenotesSnapshot.hasData &&
                      typenotesSnapshot.data!.isEmpty) &&
                  (notesSnapshot.hasData && notesSnapshot.data!.isEmpty)) {
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
                initializeDateFormatting();
                return Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
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
                      FutureBuilder<List<Map<String, dynamic>>>(
                        future: getTypenotes(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text(
                                'Une erreur s\'est produite: ${snapshot.error}');
                          } else if (snapshot.hasData &&
                              snapshot.data!.isEmpty) {
                            return const Column(
                              children: [
                                SizedBox(height: 16.0),
                                Text("Aucun dossier"),
                                SizedBox(height: 16.0),
                                SizedBox(height: 16.0),
                              ],
                            );
                          } else {
                            final typenotelist = snapshot.data;

                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: typenotelist!.map((typenote) {
                                  int id = typenote["id_typenote"];
                                  return Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  FolderContainEmpty(
                                                title: 'WriteMe',
                                                id: id,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  image: const DecorationImage(
                                                    image: AssetImage(
                                                        'lib/images/logov2.png'),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  border: Border.all(
                                                      color:
                                                          const Color.fromRGBO(
                                                              61,
                                                              110,
                                                              201,
                                                              1.0),
                                                      width: 2.0),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(10))),
                                              width: 110,
                                              height: 110,
                                            ),
                                            Container(
                                              width: 120.0,
                                              height: 30.0,
                                              margin: const EdgeInsets.only(
                                                  right: 10.0,
                                                  top: 10.0,
                                                  bottom: 35),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    typenote['intitule_type'],
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  Text(
                                                    DateFormat(
                                                            "dd MMM", 'fr_FR')
                                                        .format(DateTime
                                                            .fromMillisecondsSinceEpoch(
                                                                typenote[
                                                                    'date_creation']))
                                                        .toString(),
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 11,
                                                      color: Color.fromRGBO(
                                                          16, 43, 64, 0.5),
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
                            );
                          }
                        },
                      ),
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
                                        id: note["id_note"],
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
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return SizedBox(
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
                        Navigator.pushReplacementNamed(
                          context,
                          '/note',
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
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Center(
                                child: Text(
                                  'Nouveau dossier',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20.0,
                                    color: Color.fromRGBO(61, 110, 201, 1.0),
                                  ),
                                ),
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10, bottom: 15),
                                    child: TextField(
                                      controller: intituletypeController,
                                      style: const TextStyle(
                                        color: Color.fromRGBO(16, 43, 64, 1),
                                      ),
                                      decoration: const InputDecoration(
                                        labelText: 'Nom du dossier',
                                        labelStyle: TextStyle(
                                          color: Color.fromRGBO(16, 43, 64, 1),
                                        ),
                                        hintText: 'Nommez le dossier',
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
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
                                    'Confirmer',
                                    style: TextStyle(
                                      color: Color.fromRGBO(61, 110, 201, 1.0),
                                    ),
                                  ),
                                  onPressed: () async {
                                    final intitule_type =
                                        intituletypeController.text;

                                    final dateCreation = DateTime.now();
                                    final dateModification = DateTime.now();

                                    if (intitule_type == "") {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Center(
                                              child: Text(
                                                'Erreur',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 20.0,
                                                  color: Color.fromRGBO(
                                                      61, 110, 201, 1.0),
                                                ),
                                              ),
                                            ),
                                            content: const Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10,
                                                      right: 10,
                                                      bottom: 15),
                                                  child: Text(
                                                    'Zone de texte vide!',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 15.0,
                                                      color: Color.fromRGBO(
                                                          61, 110, 201, 1.0),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            actions: [
                                              TextButton(
                                                child: const Text(
                                                  'Fermer',
                                                  style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        61, 110, 201, 1.0),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    } else {
                                      if (intitule_type != "") {
                                        final typenoteId =
                                            await DatabaseHelper.createTypeNote(
                                                intitule_type,
                                                dateCreation,
                                                dateModification);
                                        if (typenoteId != 0) {
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => const MyApp(),
                                            ),
                                            (Route<dynamic> route) => false,
                                          );
                                        } else {
                                          print(
                                              'Erreur lors de l\'insertion de la note.');
                                        }
                                      } else {
                                        print("Erreur");
                                      }
                                    }
                                  },
                                ),
                              ],
                            );
                          },
                        );
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
