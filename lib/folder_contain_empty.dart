import 'package:flutter/material.dart';
import 'package:write_me/database_helper.dart';
import 'package:write_me/models/notes.dart';

import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:write_me/models/type_note.dart';
import 'package:write_me/note_print_folder.dart';
import 'package:write_me/note_update_folder.dart';

import 'home.dart';

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

class MyListTile extends StatelessWidget {
  final int id;
  final DateTime dateCreation;
  final DateTime dateModification;
  final String titre;
  final String texte;
  final int typeNoteId;

  const MyListTile(
      {super.key,
      required this.id,
      required this.dateCreation,
      required this.dateModification,
      required this.titre,
      required this.texte,
      required this.typeNoteId});

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
            builder: (context) => NotePrintFolder(
              id: id,
              dateCreation: dateCreation,
              dateModification: dateModification,
              titre: titre,
              texte: texte,
              typeNoteId: typeNoteId,
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
                    builder: (context) => NoteUpdateFolder(
                      id: id,
                      dateCreation: dateCreation,
                      dateModification: dateModification,
                      titre: titre,
                      texte: texte,
                      typeNoteId: typeNoteId,
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
                                  builder: (_) => FolderContainEmpty(
                                    id: typeNoteId,
                                    title: '',
                                  ),
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

class _MyFolderContainEmptyState extends State<MyFolderContainEmpty> {
  late Future<Type_Note?> type_note;

  late Future<List<NoteUser>> _notes;

  late Future<List<NoteUser>> _listallnotes;

  String? selectedItem;

  @override
  void initState() {
    super.initState();
    fetchTypeNote();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    _notes = DatabaseHelper.getNoteByType(widget.id);
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
          onPressed: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => const MyApp(),
            ),
            (Route<dynamic> route) => false,
          ),
        ),
        title: FutureBuilder<Type_Note?>(
          future: type_note,
          builder: (context, snapshot) {
            final typeNote = snapshot.data;
            return Text(typeNote!.intitule_type);
          },
        ),
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
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Center(
                            child: Text(
                              'Renommer le dossier',
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
                                    hintText: 'Renommez le dossier',
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
                                DateTime dateCreationInit = DateTime.now();
                                FutureBuilder<Type_Note?>(
                                    future: type_note,
                                    builder: (context, snapshot) {
                                      final typeNote = snapshot.data;
                                      dateCreationInit =
                                          typeNote!.date_creation;
                                      return Text(
                                          typeNote.date_creation as String);
                                    });

                                final dateCreation = dateCreationInit;
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
                                    var typenoteUpdate = Type_Note(
                                        id_type_note: widget.id,
                                        intitule_type: intitule_type,
                                        date_creation: dateCreation,
                                        date_modification: dateModification);
                                    final typenoteId =
                                        await DatabaseHelper.updateTypeNote(
                                            typenoteUpdate);
                                    if (typenoteId != 0) {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => FolderContainEmpty(
                                            id: widget.id,
                                            title: '',
                                          ),
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
                                  "Etes-vous sûr de vouloir supprimer ce dossier et toutes ses notes?",
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
                                  FutureBuilder<List<NoteUser>>(
                                      future: _notes,
                                      builder: (context, snapshot) {
                                        final notes = snapshot.data;

                                        notes!.map((note) async {
                                          int id_note = note.id_note;
                                          await DatabaseHelper.deleteNote(
                                              id_note);
                                        });
                                        return const Text("");
                                      });

                                  await DatabaseHelper.deleteTypeNote(
                                      widget.id);
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
              },
            ),
          ],
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => const MyApp(),
            ),
            (Route<dynamic> route) => false,
          );
          return true;
        },
        child: FutureBuilder<List<NoteUser>>(
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
                                      dateModification: note.date_modification,
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
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return StatefulBuilder(
                                builder: (context, setState) {
                              return AlertDialog(
                                  title: const Text(
                                    'Sélectionnez un élément',
                                    style: TextStyle(
                                      color: Color.fromRGBO(16, 43, 64, 1),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
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
                                          color:
                                              Color.fromRGBO(61, 110, 201, 1.0),
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
                                          color:
                                              Color.fromRGBO(61, 110, 201, 1.0),
                                        ),
                                      ),
                                      onPressed: () async {
                                        if (id_note != 0) {
                                          NoteUser? finalNote =
                                              await DatabaseHelper.getNote(
                                                  id_note);

                                          if (finalNote != null) {
                                            initializeDateFormatting();

                                            finalNote.type_note_id = widget.id;
                                            finalNote.date_modification =
                                                DateTime.now();
                                            int updateNote =
                                                await DatabaseHelper.updateNote(
                                                    finalNote);
                                            if (updateNote != 0) {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) =>
                                                      FolderContainEmpty(
                                                    title: 'WriteMe',
                                                    id: widget.id,
                                                  ),
                                                ),
                                              );
                                            }
                                          } else {
                                            print('Erreur ');
                                          }
                                        }
                                      },
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
        backgroundColor: const Color.fromRGBO(61, 110, 201, 1.0),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
