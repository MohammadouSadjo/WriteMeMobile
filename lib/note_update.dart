import 'package:flutter/material.dart';
import 'package:write_me/database_helper.dart';
import 'package:write_me/home.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class NoteUpdate extends StatelessWidget {
  const NoteUpdate(
      {super.key,
      required this.id,
      required this.dateCreation,
      required this.dateModification,
      required this.titre,
      required this.texte});

  final int id;
  final DateTime dateCreation;
  final DateTime dateModification;
  final String titre;
  final String texte;

  @override
  Widget build(BuildContext context) {
    return NoteUpdatePage(
        title: "Paramètres",
        id: id,
        titre: titre,
        dateCreation: dateCreation,
        dateModification: dateModification,
        texte: texte);
  }
}

class NoteUpdatePage extends StatefulWidget {
  const NoteUpdatePage(
      {super.key,
      required this.title,
      required this.id,
      required this.titre,
      required this.dateCreation,
      required this.dateModification,
      required this.texte});

  final String title;
  final int id;
  final DateTime dateCreation;
  final DateTime dateModification;
  final String titre;
  final String texte;

  @override
  State<NoteUpdatePage> createState() => _NoteUpdatePageState();
}

class _NoteUpdatePageState extends State<NoteUpdatePage> {
  String? selectedItem;

  List<String> items = [
    'Élément 1',
    'Élément 2',
    'Élément 3',
    'Élément 4',
    'Élément 5',
    'Élément 6',
    'Élément 7',
    'Élément 8',
    'Élément 9',
    'Élément 10',
    'Élément 11',
    'Élément 12',
  ];

  late Future<List<Map<String, dynamic>>> _typenotes;

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
    titreController.text = widget.titre;
    TextEditingController texteController = TextEditingController();
    texteController.text = widget.texte;
    TextEditingController intituledossierController = TextEditingController();

    initializeDateFormatting();

    final formatter = DateFormat.E('fr');
    String jourlettre = formatter.format(widget.dateModification);
    String jourChiffre =
        DateFormat("dd", 'fr_FR').format(widget.dateModification);
    String mois = DateFormat("MM", 'fr_FR').format(widget.dateModification);
    String annee = DateFormat("y", 'fr_FR').format(widget.dateModification);

    String heure = DateFormat('HH:mm', 'fr_FR').format(widget.dateModification);

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
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(widget.titre),
        backgroundColor: const Color.fromRGBO(61, 110, 201, 1.0),
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
                  color: Color.fromRGBO(16, 43, 64, 1),
                )),
            const SizedBox(height: 16.0),
            TextField(
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 17.0,
                color: Color.fromRGBO(16, 43, 64, 1),
              ),
              cursorColor: const Color.fromRGBO(16, 43, 64, 1),
              decoration: const InputDecoration(
                hintText: 'Titre de la note',
              ),
              controller: titreController,
              onChanged: (value) {},
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
        backgroundColor: const Color.fromRGBO(61, 110, 201, 1.0),
        onPressed: () {
          final titre = titreController.text;
          final texte = texteController.text;
          if (titre == "" || texte == "") {
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
                        color: Color.fromRGBO(61, 110, 201, 1.0),
                      ),
                    ),
                  ),
                  content: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(left: 10, right: 10, bottom: 15),
                        child: Text(
                          'Zone(s) de texte vides!',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15.0,
                            color: Color.fromRGBO(61, 110, 201, 1.0),
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
                          color: Color.fromRGBO(61, 110, 201, 1.0),
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
            int id_typenote = 0;

            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Center(
                      child: Text(
                        'Note Modifiée',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20.0,
                          color: Color.fromRGBO(61, 110, 201, 1.0),
                        ),
                      ),
                    ),
                    content: const Text(
                      "Ajouter la note à un dossier?",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15.0,
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: const Text(
                          'Non',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15.0,
                            color: Colors.redAccent,
                          ),
                        ),
                        onPressed: () async {
                          final id = widget.id;

                          final titre = titreController.text;
                          final texte = texteController.text;

                          final dateCreation = widget.dateCreation;
                          final dateModification = DateTime.now();

                          if (titre != "" && texte != "") {
                            final noteId = await DatabaseHelper.updateNote(
                                id,
                                titre,
                                texte,
                                dateCreation,
                                dateModification,
                                0);
                            if (noteId != 0) {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const MyApp(),
                                ),
                                (Route<dynamic> route) => false,
                              );
                            } else {
                              print('Erreur lors de l\'insertion de la note.');
                            }
                          } else {
                            print("Erreur");
                          }
                        },
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
                                    style: TextStyle(
                                      color: Color.fromRGBO(16, 43, 64, 1),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  content: SizedBox(
                                    width: 300,
                                    height: 300,
                                    child: FutureBuilder<
                                        List<Map<String, dynamic>>>(
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
                                            itemCount: snapshot.data!.length,
                                            itemBuilder: (context, index) {
                                              final typenote =
                                                  snapshot.data![index];
                                              return ListTile(
                                                title: Text(
                                                    typenote["intitule_type"]),
                                                onTap: () {
                                                  id_typenote =
                                                      typenote["id_typenote"];
                                                  setState(() {
                                                    selectedItem = typenote[
                                                            "intitule_type"]
                                                        as String?;
                                                  });
                                                },
                                                tileColor: selectedItem ==
                                                        typenote[
                                                                "intitule_type"]
                                                            as String?
                                                    ? const Color.fromRGBO(
                                                        16, 43, 64, 1)
                                                    : null,
                                                textColor: selectedItem ==
                                                        typenote[
                                                                "intitule_type"]
                                                            as String?
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
                                      onPressed: () {
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
                                                    color: Color.fromRGBO(
                                                        61, 110, 201, 1.0),
                                                  ),
                                                ),
                                              ),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            right: 10,
                                                            bottom: 15),
                                                    child: TextField(
                                                      controller:
                                                          intituledossierController,
                                                      style: const TextStyle(
                                                        color: Color.fromRGBO(
                                                            16, 43, 64, 1),
                                                      ),
                                                      decoration:
                                                          const InputDecoration(
                                                        labelText:
                                                            'Nom du dossier',
                                                        labelStyle: TextStyle(
                                                          color: Color.fromRGBO(
                                                              16, 43, 64, 1),
                                                        ),
                                                        hintText:
                                                            'Nommez le dossier',
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
                                                      color: Color.fromRGBO(
                                                          61, 110, 201, 1.0),
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
                                                      color: Color.fromRGBO(
                                                          61, 110, 201, 1.0),
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

                                                    if (intitule_type == "") {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            title: const Center(
                                                              child: Text(
                                                                'Erreur',
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize:
                                                                      20.0,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          61,
                                                                          110,
                                                                          201,
                                                                          1.0),
                                                                ),
                                                              ),
                                                            ),
                                                            content:
                                                                const Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              10,
                                                                          right:
                                                                              10,
                                                                          bottom:
                                                                              15),
                                                                  child: Text(
                                                                    'Zone de texte vide!',
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          15.0,
                                                                      color: Color.fromRGBO(
                                                                          61,
                                                                          110,
                                                                          201,
                                                                          1.0),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            actions: [
                                                              TextButton(
                                                                child:
                                                                    const Text(
                                                                  'Fermer',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            61,
                                                                            110,
                                                                            201,
                                                                            1.0),
                                                                  ),
                                                                ),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    } else {
                                                      if (intitule_type != "") {
                                                        final typenoteId =
                                                            await DatabaseHelper
                                                                .createTypeNote(
                                                                    intitule_type,
                                                                    dateCreation,
                                                                    dateModification);
                                                        if (typenoteId != 0) {
                                                          final id = widget.id;
                                                          final titre =
                                                              titreController
                                                                  .text;
                                                          final texte =
                                                              texteController
                                                                  .text;
                                                          final dateCreation =
                                                              widget
                                                                  .dateCreation;
                                                          final dateModification =
                                                              DateTime.now();

                                                          if (titre != "" &&
                                                              texte != "") {
                                                            print("Insertion");
                                                            final noteId = await DatabaseHelper
                                                                .updateNote(
                                                                    id,
                                                                    titre,
                                                                    texte,
                                                                    dateCreation,
                                                                    dateModification,
                                                                    typenoteId);
                                                            if (noteId != 0) {
                                                              print(
                                                                  "redirection");
                                                              Navigator
                                                                  .pushAndRemoveUntil(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder: (_) =>
                                                                      const MyApp(),
                                                                ),
                                                                (Route<dynamic>
                                                                        route) =>
                                                                    false,
                                                              );
                                                            } else {
                                                              print(
                                                                  'Erreur lors de l\'insertion de la note.');
                                                            }
                                                          } else {
                                                            print("Erreur");
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
                                          color: Color.fromRGBO(16, 43, 64, 1),
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
                                    TextButton(
                                      onPressed: () async {
                                        final id = widget.id;
                                        final titre = titreController.text;
                                        final texte = texteController.text;

                                        final dateCreation =
                                            widget.dateCreation;
                                        final dateModification = DateTime.now();

                                        if (selectedItem != null) {
                                          if (titre != "" && texte != "") {
                                            print("Insertion");
                                            final noteId =
                                                await DatabaseHelper.updateNote(
                                                    id,
                                                    titre,
                                                    texte,
                                                    dateCreation,
                                                    dateModification,
                                                    id_typenote);
                                            if (noteId != 0) {
                                              print("redirection");
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

                                          print(
                                              'Élément sélectionné : $selectedItem');
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
                                  ],
                                );
                              });
                            },
                          );
                        },
                      ),
                    ],
                  );
                });
          }
        },
        tooltip: 'Enregistrer la note',
        child: const Icon(Icons.save),
      ),
    );
  }
}
