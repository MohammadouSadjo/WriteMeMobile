import 'package:flutter/material.dart';
import 'package:write_me/database_helper.dart';
import 'package:write_me/folder_contain_empty.dart';
import 'package:write_me/home.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

// ignore: import_of_legacy_library_into_null_safe

void main() {
  runApp(const NoteFolder());
}

class NoteFolder extends StatelessWidget {
  const NoteFolder({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final id = arguments?['id'] as int?;

    return NoteFolderPage(title: "Paramètres", id: id);
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

class NoteFolderPage extends StatefulWidget {
  const NoteFolderPage({super.key, required this.title, int? id});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<NoteFolderPage> createState() => _NotePageState();
}

class _NotePageState extends State<NoteFolderPage> {
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
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final id = arguments?['id'] as int?;

    TextEditingController titreController = TextEditingController();
    TextEditingController texteController = TextEditingController();

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
        onPressed: () async {
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
            // Récupérez le titre et le contenu de la note depuis les champs de texte.
            final titre = titreController
                .text; // Remplacez par la valeur du champ de titre.
            final texte = texteController
                .text; // Remplacez par la valeur du champ de contenu.

            // Obtenez la date de création et de modification actuelle.
            final dateCreation = DateTime.now();
            final dateModification = DateTime.now();

            int id_folder = id!;

            // Obtenez l'ID du type de note approprié.
            //final typenoteId =
            //1; // Remplacez par l'ID du type de note approprié.

            // Appelez la fonction d'insertion de note dans DatabaseHelper.
            if (titre != "" && texte != "") {
              print("Insertion");
              final noteId = await DatabaseHelper.createNote(
                  titre, texte, dateCreation, dateModification, id);
              if (noteId != null) {
                print("redirection");
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FolderContainEmpty(
                      title: 'WriteMe',
                      id: id,
                    ),
                  ),
                  //(Route<dynamic> route) => false,
                );
              } else {
                print('Erreur lors de l\'insertion de la note.');
              }
            } else {
              print("Erreur");
            }
          }
        },
        tooltip: 'Enregistrer la note',
        child: const Icon(Icons.save),
      ),
    );
  }
}
