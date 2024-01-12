import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:write_me/database_helper.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:write_me/models/dto/notesRequest.dart';
import 'package:write_me/models/dto/type_noteRequest.dart';
import 'package:write_me/models/type_note.dart';
import 'package:write_me/providers/listNotesProvider.dart';
import 'package:write_me/providers/typeNoteProvider.dart';
import 'package:write_me/utils/constants/colors.dart';
import 'package:write_me/utils/customWidgets/dialogs/errorEmpty/errorModal.dart';
import 'package:write_me/utils/constants/textStyleModalContent.dart';

import 'utils/constants/textStyleModalTitle.dart';

void main() {
  runApp(const Note());
}

class Note extends StatelessWidget {
  const Note({super.key});

  @override
  Widget build(BuildContext context) {
    return const NotePage(title: "Paramètres");
  }
}

class NotePage extends StatefulWidget {
  const NotePage({super.key, required this.title});

  final String title;

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  String? selectedItem;

  late Future<List<Type_Note>> _typenotes;

  @override
  void initState() {
    super.initState();
    _loadTypeNotes();
  }

  Future<void> _loadTypeNotes() async {
    _typenotes = DatabaseHelper.getTypeNotes();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController titreController = TextEditingController();
    TextEditingController texteController = TextEditingController();
    TextEditingController intituledossierController = TextEditingController();

    initializeDateFormatting();
    final DateTime now = DateTime.now();

    final formatter = DateFormat.E('fr');
    String jourlettre = formatter.format(now);
    String jourChiffre = DateFormat("dd", 'fr_FR').format(now);
    String mois = DateFormat("MM", 'fr_FR').format(now);
    String annee = DateFormat("y", 'fr_FR').format(now);

    String heure = DateFormat('HH:mm', 'fr_FR').format(now);

    String dateTime = jourlettre +
        " " +
        jourChiffre +
        "." +
        mois +
        "." +
        annee +
        " | " +
        heure;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.popUntil(
              context, (route) => route.isFirst) /*Navigator.pop(context)*/,
        ),
        title: const Text('Ajouter une note'),
        backgroundColor: Utils.mainColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(dateTime,
                style: const TextStyle(
                  fontFamily: 'RobotoSlab',
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                  color: Utils.secondaryColor,
                )),
            const SizedBox(height: 16.0),
            TextField(
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 17.0,
                color: Utils.secondaryColor,
              ),
              cursorColor: Utils.secondaryColor,
              decoration: const InputDecoration(
                hintText: 'Titre de la note',
              ),
              controller: titreController,
              onChanged: (value) {},
              //onTapOutside: ,
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: TextField(
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: 'Contenu de la note',
                  border: InputBorder.none,
                ),
                controller: texteController,
                onChanged: (value) {},
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Utils.mainColor,
        onPressed: () {
          FocusManager.instance.primaryFocus?.unfocus();
          final titre = titreController.text;
          final texte = texteController.text;
          if (titre == "" || texte == "") {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return ErrorModal(context);
              },
            );
          } else {
            int id_typenote = 0;

            showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Center(
                          child: Text(
                            'Note créée',
                            style: TextStyleModalTitle.style,
                          ),
                        ),
                        content: const Text(
                          "Ajouter la note à un dossier?",
                          style: TextStyleModalContent.style,
                        ),
                        actions: [
                          Consumer<ListNotesProvider>(
                            builder: (context, notesProvider, child) =>
                                TextButton(
                              child: const Text(
                                'Non',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.0,
                                  color: Colors.redAccent,
                                ),
                              ),
                              onPressed: () {
                                final titre = titreController.text;
                                final texte = texteController.text;

                                final dateCreation = DateTime.now();
                                final dateModification = DateTime.now();

                                var note = NoteUserRequest(
                                    type_note_id: 0,
                                    titre: titre,
                                    texte: texte,
                                    date_creation: dateCreation,
                                    date_modification: dateModification);

                                if (titre != "" && texte != "") {
                                  //Navigator.of(context).popUntil((route) => false)
                                  notesProvider.addNote(note);
                                  Navigator.popUntil(
                                      context, (route) => route.isFirst);
                                  /*Navigator.popUntil(
                                context,
                                ModalRoute.withName('/home'),
                              );*/
                                  /*var nav = Navigator.of(context);
                              nav.pop();
                              nav.pop();*/

                                  /*Navigator.of(context).pop();
                              Navigator.of(context).pop();*/
                                } else {
                                  print("Erreur");
                                }
                              },
                            ),
                          ),
                          TextButton(
                            child: const Text(
                              'Oui',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15.0,
                                color: Colors.greenAccent,
                              ),
                            ),
                            onPressed: () {
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
                                      content: SizedBox(
                                        width: 300,
                                        height: 300,
                                        child: FutureBuilder<List<Type_Note>>(
                                          future: _typenotes,
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
                                                itemCount:
                                                    snapshot.data!.length,
                                                itemBuilder: (context, index) {
                                                  final typenote =
                                                      snapshot.data![index];
                                                  return ListTile(
                                                    title: Text(
                                                        typenote.intitule_type),
                                                    onTap: () {
                                                      id_typenote =
                                                          typenote.id_type_note;
                                                      print(id_typenote);
                                                      setState(() {
                                                        selectedItem = typenote
                                                            .intitule_type;
                                                      });
                                                    },
                                                    tileColor: selectedItem ==
                                                            typenote
                                                                .intitule_type
                                                        ? const Color.fromRGBO(
                                                            16, 43, 64, 1)
                                                        : null,
                                                    textColor: selectedItem ==
                                                            typenote
                                                                .intitule_type
                                                        ? Colors.white //
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
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Center(
                                                    child: Text(
                                                      'Nouveau dossier',
                                                      style: TextStyleModalTitle
                                                          .style,
                                                    ),
                                                  ),
                                                  content: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 10,
                                                                right: 10,
                                                                bottom: 15),
                                                        child: TextField(
                                                          controller:
                                                              intituledossierController,
                                                          style:
                                                              const TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    16,
                                                                    43,
                                                                    64,
                                                                    1),
                                                          ),
                                                          decoration:
                                                              const InputDecoration(
                                                            labelText:
                                                                'Nom du dossier',
                                                            labelStyle:
                                                                TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      16,
                                                                      43,
                                                                      64,
                                                                      1),
                                                            ),
                                                            hintText:
                                                                'Nommez le dossier',
                                                            hintStyle:
                                                                TextStyle(
                                                              color:
                                                                  Colors.grey,
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
                                                          color: Color.fromRGBO(
                                                              61,
                                                              110,
                                                              201,
                                                              1.0),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                    Consumer2<TypeNoteProvider,
                                                        ListNotesProvider>(
                                                      builder: (context,
                                                              typenotesProvider,
                                                              notesProvider,
                                                              child) =>
                                                          TextButton(
                                                        child: const Text(
                                                          'Confirmer',
                                                          style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    61,
                                                                    110,
                                                                    201,
                                                                    1.0),
                                                          ),
                                                        ),
                                                        onPressed: () async {
                                                          final intitule_type =
                                                              intituledossierController
                                                                  .text;
                                                          final dateCreation =
                                                              DateTime.now();
                                                          final dateModification =
                                                              DateTime.now();

                                                          if (intitule_type ==
                                                              "") {
                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return ErrorModal(
                                                                    context);
                                                              },
                                                            );
                                                          } else {
                                                            if (intitule_type !=
                                                                "") {
                                                              var type_note = Type_NoteRequest(
                                                                  intitule_type:
                                                                      intitule_type,
                                                                  date_creation:
                                                                      dateCreation,
                                                                  date_modification:
                                                                      dateModification);
                                                              int typenoteId =
                                                                  await typenotesProvider
                                                                      .addTypeNote(
                                                                          type_note);
                                                              /*final typenoteId =
                                                                  await DatabaseHelper
                                                                      .createTypeNote(
                                                                          type_note);*/
                                                              if (typenoteId !=
                                                                  0) {
                                                                final titre =
                                                                    titreController
                                                                        .text;
                                                                final texte =
                                                                    texteController
                                                                        .text;
                                                                final dateCreation =
                                                                    DateTime
                                                                        .now();
                                                                final dateModification =
                                                                    DateTime
                                                                        .now();

                                                                if (titre !=
                                                                        "" &&
                                                                    texte !=
                                                                        "") {
                                                                  var note = NoteUserRequest(
                                                                      type_note_id:
                                                                          typenoteId,
                                                                      titre:
                                                                          titre,
                                                                      texte:
                                                                          texte,
                                                                      date_creation:
                                                                          dateCreation,
                                                                      date_modification:
                                                                          dateModification);
                                                                  notesProvider
                                                                      .addNote(
                                                                          note);
                                                                  Navigator.popUntil(
                                                                      context,
                                                                      (route) =>
                                                                          route
                                                                              .isFirst);
                                                                  /*final noteId =
                                                                      await DatabaseHelper
                                                                          .createNote(
                                                                              note);
                                                                  if (noteId !=
                                                                      0) {
                                                                    Navigator
                                                                        .pushAndRemoveUntil(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (_) =>
                                                                                const MyApp(),
                                                                      ),
                                                                      (Route<dynamic>
                                                                              route) =>
                                                                          false,
                                                                    );
                                                                  } else {
                                                                    print(
                                                                        'Erreur lors de l\'insertion de la note.');
                                                                  }*/
                                                                } else {
                                                                  print(
                                                                      "Erreur");
                                                                }
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
                                                    )
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          child: const Text(
                                            'Nouveau Dossier',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15.0,
                                              color: Utils.secondaryColor,
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text(
                                            'Annuler',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15.0,
                                              color: Colors.redAccent,
                                            ),
                                          ),
                                        ),
                                        Consumer<ListNotesProvider>(
                                          builder:
                                              (context, notesProvider, child) =>
                                                  TextButton(
                                            onPressed: () async {
                                              final titre =
                                                  titreController.text;
                                              final texte =
                                                  texteController.text;

                                              final dateCreation =
                                                  DateTime.now();
                                              final dateModification =
                                                  DateTime.now();
                                              if (selectedItem != null) {
                                                if (titre != "" &&
                                                    texte != "") {
                                                  var note = NoteUserRequest(
                                                      type_note_id: id_typenote,
                                                      titre: titre,
                                                      texte: texte,
                                                      date_creation:
                                                          dateCreation,
                                                      date_modification:
                                                          dateModification);
                                                  notesProvider.addNote(note);
                                                  Navigator.popUntil(context,
                                                      (route) => route.isFirst);
                                                  /*final noteId =
                                                      await DatabaseHelper
                                                          .createNote(note);
                                                  if (noteId != 0) {
                                                    print("redirection");
                                                    Navigator
                                                        .pushAndRemoveUntil(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (_) =>
                                                            const MyApp(),
                                                      ),
                                                      (Route<dynamic> route) =>
                                                          false,
                                                    );
                                                  } else {
                                                    print(
                                                        'Erreur lors de l\'insertion de la note.');
                                                  }*/
                                                } else {
                                                  print("Erreur");
                                                }

                                                print(
                                                    'Élément sélectionné : $selectedItem');
                                              } else {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return ErrorModal(context);
                                                  },
                                                );
                                              }
                                            },
                                            child: const Text(
                                              'Valider',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15.0,
                                                color: Colors.greenAccent,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  });
                                },
                              );
                            },
                          ),
                        ],
                      );
                    })
                .whenComplete(() =>
                    Navigator.popUntil(context, (route) => route.isFirst));
          }
        },
        tooltip: 'Enregistrer la note',
        child: const Icon(Icons.save),
      ),
    );
  }
}
