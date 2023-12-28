import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:write_me/home.dart';
import 'package:write_me/models/notes.dart';
import 'package:write_me/models/type_note.dart';
import 'package:write_me/utils/customWidgets/myTypeNote.dart';

import 'database_helper.dart';
import 'utils/CustomWidgets/myListTile.dart';
import 'utils/colors.dart';

class MyAppResearch extends StatelessWidget {
  const MyAppResearch(
      {super.key, required this.research, required String title});

  final String research;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MyHomePageResearch(
      title: 'Research',
      research: research,
    );
  }
}

class MyHomePageResearch extends StatefulWidget {
  const MyHomePageResearch(
      {super.key, required this.title, required this.research});

  final String title;
  final String research;

  @override
  State<MyHomePageResearch> createState() => _MyHomePageResearchState();
}

class _MyHomePageResearchState extends State<MyHomePageResearch> {
  List<Type_Note> dossiers = [];

  late Future<List<NoteUser>> _notes;
  late Future<List<Type_Note>> _typenotes;

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    _notes = DatabaseHelper.getNotesByResearch(widget.research);
    _typenotes = DatabaseHelper.getTypeNotesByResearch(widget.research);
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(
      Utils.mainColor,
    );

    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MyApp(),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
            );
          },
        ),
        title: Text(widget.title),
        actions: [],
        backgroundColor: Utils.mainColor,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              color: Utils.secondaryColor,
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
          ],
        ),
      ),
      body: FutureBuilder<List<Type_Note>>(
        future: _typenotes,
        builder: (context, typenotesSnapshot) {
          return FutureBuilder<List<NoteUser>>(
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
                        "Aucun résultat",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17.0,
                          color: Colors.grey,
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
                            color: Utils.secondaryColor,
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
                      FutureBuilder<List<Type_Note>>(
                        future: _typenotes,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            // En cas d'erreur
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
                                  int id = typenote.id_type_note;
                                  return MyTypeNote(id, typenote);
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
                            color: Utils.secondaryColor,
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
                        child: FutureBuilder<List<NoteUser>>(
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
                                        id: note.id_note,
                                        dateCreation: note.date_creation,
                                        dateModification:
                                            note.date_modification,
                                        titre: note.titre,
                                        texte: note.texte,
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
    );
  }
}
