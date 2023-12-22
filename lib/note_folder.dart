import 'package:flutter/material.dart';
import 'package:write_me/database_helper.dart';
import 'package:write_me/folder_contain_empty.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:write_me/models/dto/notesRequest.dart';

void main() {
  runApp(const NoteFolder());
}

class NoteFolder extends StatelessWidget {
  const NoteFolder({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final id = arguments?['id'] as int?;

    return NoteFolderPage(title: "Paramètres", id: id);
  }
}

class NoteFolderPage extends StatefulWidget {
  const NoteFolderPage({super.key, required this.title, int? id});

  final String title;

  @override
  State<NoteFolderPage> createState() => _NotePageState();
}

class _NotePageState extends State<NoteFolderPage> {
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
        onPressed: () async {
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
            final titre = titreController.text;
            final texte = texteController.text;
            final dateCreation = DateTime.now();
            final dateModification = DateTime.now();

            if (titre != "" && texte != "") {
              var note = NoteUserRequest(
                  type_note_id: id,
                  titre: titre,
                  texte: texte,
                  date_creation: dateCreation,
                  date_modification: dateModification);
              final noteId = await DatabaseHelper.createNote(note);
              if (noteId != 0) {
                print("redirection");
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FolderContainEmpty(
                      title: 'WriteMe',
                      id: id!,
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
