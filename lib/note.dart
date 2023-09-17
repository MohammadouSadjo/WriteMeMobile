import 'package:flutter/material.dart';
import 'package:write_me/database_helper.dart';
import 'package:write_me/home.dart';

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

  @override
  Widget build(BuildContext context) {
    TextEditingController titreController = TextEditingController();
    TextEditingController texteController = TextEditingController();

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
            const Text('Jeu 26.04.2023 | 10:34',
                //'Date: ${DateFormat('dd/MM/yyyy').format(_selectedDate)}',
                style: TextStyle(
                  fontFamily: 'Nova Round',
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
                        final noteId = await DatabaseHelper.createNote(
                            titre, texte, dateCreation, dateModification, 0);

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
                                  width: 300, // Largeur fixe de la fenêtre
                                  height: 300, // Hauteur fixe de la fenêtre
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
                                        tileColor: selectedItem == items[index]
                                            ? const Color.fromRGBO(16, 43, 64,
                                                1) // Couleur de surbrillance
                                            : null,
                                        textColor: selectedItem == items[index]
                                            ? Colors
                                                .white // Couleur de surbrillance
                                            : null,
                                      );
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
                                            content: const Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Padding(
                                                  //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                                                  padding: EdgeInsets.only(
                                                      left: 10,
                                                      right: 10,
                                                      bottom: 15),
                                                  child: TextField(
                                                    style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          16, 43, 64, 1),
                                                    ),
                                                    decoration: InputDecoration(
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
                                                onPressed: () {
                                                  // code à exécuter lorsque l'utilisateur clique sur le bouton Rechercher
                                                  Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (_) =>
                                                          const MyApp(),
                                                    ),
                                                    (Route<dynamic> route) =>
                                                        false,
                                                  );
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
                                    onPressed: () {
                                      // Faites quelque chose avec l'élément sélectionné (selectedItem)
                                      if (selectedItem != null) {
                                        print(
                                            'Élément sélectionné : $selectedItem');
                                      }
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => const MyApp(),
                                        ),
                                        (Route<dynamic> route) => false,
                                      );
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
        },
        tooltip: 'Enregistrer la note',
        child: const Icon(Icons.save),
      ),
    );
  }
}
