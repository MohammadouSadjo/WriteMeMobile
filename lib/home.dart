import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:write_me/models/notes.dart';
import 'package:write_me/models/type_note.dart';
import 'package:write_me/note.dart';
import 'package:write_me/note_folder.dart';
import 'package:write_me/providers/listNotesProvider.dart';
import 'package:write_me/providers/typeNoteProvider.dart';
import 'package:write_me/utils/constants/colors.dart';
import 'package:write_me/utils/customWidgets/dialogs/addTypeNote.dart';
import 'package:write_me/utils/customWidgets/dialogs/research/researchModal.dart';
import 'package:write_me/utils/customWidgets/myDrawer.dart';
import 'package:write_me/utils/customWidgets/myTypeNote.dart';
import 'utils/customWidgets/myListTile.dart';

import 'database_helper.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/home': (context) => const MyApp(),
        '/note': (context) => const Note(),
        '/notefolder': (context) => const NoteFolder(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'RobotoSerif',
        primaryColor: Utils.mainColor,
      ),
      home: MyHomePage(),
    );
  }
}

// ignore: must_be_immutable
class MyHomePage extends StatelessWidget {
  List<Type_Note> dossiers = [];

  final Future<List<NoteUser>> _notes = DatabaseHelper.getNotes();
  final Future<List<Type_Note>> _typenotes = DatabaseHelper.getTypeNotes();

  MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController intituletypeController = TextEditingController();
    TextEditingController researchController = TextEditingController();
    FlutterStatusbarcolor.setStatusBarColor(Utils.mainColor);

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
        title: const Text("WriteMe"),
        actions: [
          Consumer2<ListNotesProvider, TypeNoteProvider>(
            child: IconButton(
              icon: const Icon(
                Icons.search,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ResearchModal(context, researchController);
                  },
                );
              },
            ),
            builder: (context, noteProvider, typenoteProvider, child) =>
                noteProvider.research == 0
                    ? child!
                    : IconButton(
                        icon: const Icon(
                          Icons.cancel,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          noteProvider.getAllNotes();
                          typenoteProvider.getAllTypeNotes();
                        },
                      ),
          )
        ],
        backgroundColor: Utils.mainColor,
      ),
      drawer: const MyDrawer(),
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
                print(typenotesSnapshot.error);
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
                      FutureBuilder(
                        future: Provider.of<TypeNoteProvider>(context,
                                listen: false)
                            .getAllTypeNotes(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Text(
                                'Une erreur s\'est produite: ${snapshot.error}');
                          } else {
                            return Consumer<TypeNoteProvider>(
                              child: const Column(
                                children: [
                                  SizedBox(height: 16.0),
                                  Text("Aucun dossier"),
                                  SizedBox(height: 16.0),
                                  SizedBox(height: 16.0),
                                ],
                              ),
                              builder: (context, typenotes, child) =>
                                  typenotes.alltypeNote.isEmpty
                                      ? child!
                                      : SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: typenotes.alltypeNote
                                                .map((typenote) {
                                              int id = typenote.id_type_note;
                                              return MyTypeNote(id, typenote);
                                            }).toList(),
                                          ),
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
                        child: FutureBuilder(
                          future: Provider.of<ListNotesProvider>(context,
                                  listen: false)
                              .getAllNotes(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              return Text('Erreur: ${snapshot.error}');
                            } else {
                              return Consumer<ListNotesProvider>(
                                child: const Text("Aucune note"),
                                builder: (context, listNotesProvider, child) =>
                                    listNotesProvider.allnotes.isEmpty
                                        ? child!
                                        : ListView.builder(
                                            itemCount: listNotesProvider
                                                .allnotes.length,
                                            itemBuilder: (context, index) {
                                              final note = listNotesProvider
                                                  .allnotes[index];
                                              return Column(
                                                children: [
                                                  MyListTile(
                                                    id: note.id_note,
                                                    dateCreation:
                                                        note.date_creation,
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
                                                    color: Color.fromRGBO(
                                                        16, 43, 64, 0.4),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
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
                        color: Utils.secondaryColor,
                      ),
                      title: const Text(
                        'Ajouter une note',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12.0,
                          color: Utils.secondaryColor,
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
                        color: Utils.secondaryColor,
                      ),
                      title: const Text(
                        'Ajouter un dossier',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12.0,
                          color: Utils.secondaryColor,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AddTypeNote(context, intituletypeController);
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
        backgroundColor: Utils.mainColor,
        child: const Icon(Icons.edit),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
