import 'package:flutter/material.dart';
import 'package:write_me/database_helper.dart';
import 'package:write_me/home.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

// ignore: import_of_legacy_library_into_null_safe

void main() {
  runApp(const Note());
}

class Note extends StatelessWidget {
  const Note({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const NotePage(title: "Paramètres");
    /*return MaterialApp(
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
        home: const MyParametersPage(
          title: "Paramètres",
        ));*/
  }
}

class NotePage extends StatefulWidget {
  const NotePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  //String _title;
  //String _content;
  DateTime _selectedDate = DateTime.now();

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
    //List<Type_Note> dossiers_list = _typenotes.map(dossier)
    //DatabaseHelper.getTypeNotes() as List<Type_Note>;

    /*setState(() {
      dossiers = dossiers_list;
    });*/
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController titreController = TextEditingController();
    TextEditingController texteController = TextEditingController();
    TextEditingController intituledossierController = TextEditingController();

    initializeDateFormatting();
    final DateTime now = DateTime.now();
    String formattedDate = DateFormat("dd MMM", 'fr_FR').format(now);
    String formattedDateYear = DateFormat("y", 'fr_FR').format(now);

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
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Ajouter une note'),
        backgroundColor: const Color.fromRGBO(61, 110, 201, 1.0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(dateTime,
                //'Jeu 26.04.2023 | 10:34',
                //'Date: ${DateFormat('dd/MM/yyyy').format(_selectedDate)}',
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
                //border: OutlineInputBorder(),
              ),
              controller: titreController,
              onChanged: (value) {
                /*setState(() {
                  _title = value;
                });*/
              },
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
                onChanged: (value) {
                  /*setState(() {
                    _content = value;
                  });*/
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(61, 110, 201, 1.0),
        onPressed: () {
          final titre = titreController
              .text; // Remplacez par la valeur du champ de titre.
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
                        //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
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
                        'Note créée',
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
                          // Récupérez le titre et le contenu de la note depuis les champs de texte.
                          final titre = titreController
                              .text; // Remplacez par la valeur du champ de titre.
                          final texte = texteController
                              .text; // Remplacez par la valeur du champ de contenu.

                          // Obtenez la date de création et de modification actuelle.
                          final dateCreation = DateTime.now();
                          final dateModification = DateTime.now();

                          // Obtenez l'ID du type de note approprié.
                          //final typenoteId =
                          //1; // Remplacez par l'ID du type de note approprié.

                          // Appelez la fonction d'insertion de note dans DatabaseHelper.
                          if (titre != "" && texte != "") {
                            final noteId = await DatabaseHelper.createNote(
                                titre,
                                texte,
                                dateCreation,
                                dateModification,
                                0);
                            if (noteId != null) {
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
                                  content: Container(
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
                                                  print(id_typenote);
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
                                                        16,
                                                        43,
                                                        64,
                                                        1) // Couleur de surbrillance
                                                    : null,
                                                textColor: selectedItem ==
                                                        typenote[
                                                                "intitule_type"]
                                                            as String?
                                                    ? Colors
                                                        .white // Couleur de surbrillance
                                                    : null,
                                              );
                                            },
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                  /*Container(
                                    width: 300, 
                                    height: 300, 
                                    child: ListView.builder(
                                      itemCount: items.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return ListTile(
                                          title: Text(items[index]),
                                          onTap: () {
                                            setState(() {
                                              selectedItem = items[index];
                                            });
                                          },
                                          tileColor: selectedItem ==
                                                  items[index]
                                              ? const Color.fromRGBO(16, 43, 64,
                                                  1) // Couleur de surbrillance
                                              : null,
                                          textColor: selectedItem ==
                                                  items[index]
                                              ? Colors
                                                  .white // Couleur de surbrillance
                                              : null,
                                        );
                                      },
                                    ),
                                  ),*/
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
                                                    //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
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
                                                        /*icon: Icon(
                                          Icons.person,
                                          color: Color.fromRGBO(16, 43, 64, 1),
                                        ),*/
                                                        //border: OutlineInputBorder(),
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
                                                    // Remplacez par la valeur du champ de titre.
                                                    // Remplacez par la valeur du champ de contenu.

                                                    // Obtenez la date de création et de modification actuelle.
                                                    final dateCreation =
                                                        DateTime.now();
                                                    final dateModification =
                                                        DateTime.now();

                                                    // Obtenez l'ID du type de note approprié.
                                                    //final typenoteId =
                                                    //1; // Remplacez par l'ID du type de note approprié.

                                                    // Appelez la fonction d'insertion de note dans DatabaseHelper.
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
                                                                  //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
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
                                                        if (typenoteId !=
                                                            null) {
                                                          final titre =
                                                              titreController
                                                                  .text; // Remplacez par la valeur du champ de titre.
                                                          final texte =
                                                              texteController
                                                                  .text; // Remplacez par la valeur du champ de contenu.

                                                          // Obtenez la date de création et de modification actuelle.
                                                          final dateCreation =
                                                              DateTime.now();
                                                          final dateModification =
                                                              DateTime.now();
                                                          // Faites quelque chose avec l'élément sélectionné (selectedItem)

                                                          if (titre != "" &&
                                                              texte != "") {
                                                            print("Insertion");
                                                            final noteId = await DatabaseHelper
                                                                .createNote(
                                                                    titre,
                                                                    texte,
                                                                    dateCreation,
                                                                    dateModification,
                                                                    typenoteId);
                                                            if (noteId !=
                                                                null) {
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
                                                    // code à exécuter lorsque l'utilisateur clique sur le bouton Rechercher
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
                                        final titre = titreController
                                            .text; // Remplacez par la valeur du champ de titre.
                                        final texte = texteController
                                            .text; // Remplacez par la valeur du champ de contenu.

                                        // Obtenez la date de création et de modification actuelle.
                                        final dateCreation = DateTime.now();
                                        final dateModification = DateTime.now();
                                        // Faites quelque chose avec l'élément sélectionné (selectedItem)
                                        if (selectedItem != null) {
                                          if (titre != "" && texte != "") {
                                            print("Insertion");
                                            final noteId =
                                                await DatabaseHelper.createNote(
                                                    titre,
                                                    texte,
                                                    dateCreation,
                                                    dateModification,
                                                    id_typenote);
                                            if (noteId != null) {
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
