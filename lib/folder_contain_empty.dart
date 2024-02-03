import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:write_me/database_helper.dart';
import 'package:write_me/models/notes.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:write_me/models/type_note.dart';
import 'package:write_me/providers/listNotesProvider.dart';
import 'package:write_me/providers/typeNoteProvider.dart';
import 'package:write_me/utils/constants/colors.dart';
import 'package:write_me/utils/customWidgets/dialogs/deleteTypeNote.dart';
import 'package:write_me/utils/customWidgets/dialogs/renameTypeNote.dart';
import 'package:write_me/utils/customWidgets/myListTileFolder.dart';

import 'utils/constants/textStyleModalTitle.dart';

class FolderContainEmpty extends StatelessWidget {
  const FolderContainEmpty({
    super.key,
    required this.id,
    required this.title,
  });

  final int id;
  final String title;

  @override
  Widget build(BuildContext context) {
    return MyFolderContainEmpty(
      id: id,
      title: title,
    );
  }
}

class MyFolderContainEmpty extends StatefulWidget {
  const MyFolderContainEmpty(
      {super.key, required this.title, required this.id});

  final String title;
  final int id;

  @override
  State<MyFolderContainEmpty> createState() => _MyFolderContainEmptyState();
}

class _MyFolderContainEmptyState extends State<MyFolderContainEmpty> {
  late Future<Type_Note?> type_note;

  late Future<List<NoteUser>> _listallnotes;

  String? selectedItem;

  @override
  void initState() {
    super.initState();
    fetchTypeNote();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    _listallnotes = DatabaseHelper.getNotes();
  }

  Future<void> fetchTypeNote() async {
    final id = widget.id;
    type_note = DatabaseHelper.getTypeNote(id);
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    TextEditingController intituletypeController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () =>
              Navigator.popUntil(context, (route) => route.isFirst),
        ),
        title: Consumer<TypeNoteProvider>(
            builder: (context, typenoteProvider, child) =>
                Text(typenoteProvider.typenoteName.toString())),
        actions: [
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'edit',
                  child: const Row(
                    children: <Widget>[
                      Icon(
                        Icons.edit,
                        color: Utils.secondaryColor,
                      ),
                      Text(
                        '  Renommer',
                        style: TextStyle(
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  onTap: () async {
                    Type_Note? typenote = await type_note;
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return RenameTypeNote(context, intituletypeController,
                            typenote, widget.id);
                      },
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
                        return DeleteTypeNote(context, widget.id);
                      },
                    );
                  },
                ),
              ];
            },
          ),
        ],
        backgroundColor: Utils.mainColor,
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.popUntil(context, (route) => route.isFirst);
          return true;
        },
        child: FutureBuilder(
          future: Provider.of<ListNotesProvider>(context, listen: false)
              .getAllNotesByTypeNote(widget.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Text('Une erreur s\'est produite: ${snapshot.error}');
            } else {
              initializeDateFormatting();
              return Consumer<ListNotesProvider>(
                child: Center(
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
                ),
                builder: (context, notesProvider, child) => notesProvider
                        .allnotesByType.isEmpty
                    ? child!
                    : Padding(
                        padding: const EdgeInsets.only(top: 20.0, left: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                              child: ListView.builder(
                                itemCount: notesProvider.allnotesByType.length,
                                itemBuilder: (context, index) {
                                  final note =
                                      notesProvider.allnotesByType[index];
                                  return Column(
                                    children: [
                                      MyListTileFolder(
                                        id: note.id_note,
                                        dateCreation: note.date_creation,
                                        dateModification:
                                            note.date_modification,
                                        titre: note.titre,
                                        texte: note.texte,
                                        typeNoteId: widget.id,
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
                              ),
                            ),
                          ],
                        ),
                      ),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          int id_note = 0;

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
                        color: Utils.secondaryColor,
                      ),
                      title: const Text(
                        'Ajouter une nouvelle note',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12.0,
                          color: Utils.secondaryColor,
                        ),
                      ),
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/notefolder',
                            arguments: {'id': widget.id});
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.file_upload,
                        color: Utils.secondaryColor,
                      ),
                      title: const Text(
                        'Ajouter une note existante',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12.0,
                          color: Utils.secondaryColor,
                        ),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return StatefulBuilder(
                                builder: (context, setState) {
                              return AlertDialog(
                                  title: const Text(
                                    'Sélectionnez un élément',
                                    style: TextStyleModalTitle.style,
                                  ),
                                  content: Container(
                                    width: 300,
                                    height: 300,
                                    child: FutureBuilder<List<NoteUser>>(
                                      future: _listallnotes,
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const CircularProgressIndicator();
                                        } else if (snapshot.hasError) {
                                          return Text(
                                              'Erreur: ${snapshot.error}');
                                        } else if (snapshot.hasData &&
                                            snapshot.data!.isEmpty) {
                                          return const Text("Aucune note");
                                        } else {
                                          return ListView.builder(
                                            itemCount: snapshot.data!.length,
                                            itemBuilder: (context, index) {
                                              final note =
                                                  snapshot.data![index];
                                              return ListTile(
                                                title: Text(note.titre),
                                                onTap: () {
                                                  id_note = note.id_note;
                                                  print(id_note);
                                                  setState(() {
                                                    selectedItem = note.titre;
                                                  });
                                                },
                                                tileColor:
                                                    selectedItem == note.titre
                                                        ? const Color.fromRGBO(
                                                            16, 43, 64, 1)
                                                        : null,
                                                textColor:
                                                    selectedItem == note.titre
                                                        ? Colors.white
                                                        : null,
                                              );
                                            },
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      child: const Text(
                                        'Annuler',
                                        style: TextStyle(
                                          color: Utils.mainColor,
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    Consumer2<ListNotesProvider,
                                        TypeNoteProvider>(
                                      builder: (context, notesProvider,
                                              typenoteProvider, child) =>
                                          TextButton(
                                        child: const Text(
                                          'Confirmer',
                                          style: TextStyle(
                                            color: Utils.mainColor,
                                          ),
                                        ),
                                        onPressed: () async {
                                          if (id_note != 0) {
                                            NoteUser? finalNote =
                                                await DatabaseHelper.getNote(
                                                    id_note);

                                            if (finalNote != null) {
                                              initializeDateFormatting();

                                              finalNote.type_note_id =
                                                  widget.id;
                                              finalNote.date_modification =
                                                  DateTime.now();
                                              notesProvider
                                                  .updateNote(finalNote);

                                              Navigator.of(context).pop();
                                            } else {
                                              print('Erreur ');
                                            }
                                          }
                                        },
                                      ),
                                    ),
                                  ]);
                            });
                          },
                        );

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
        backgroundColor: Utils.mainColor,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
