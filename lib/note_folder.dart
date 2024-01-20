import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:write_me/models/dto/notesRequest.dart';
import 'package:write_me/providers/listNotesProvider.dart';
import 'package:write_me/utils/constants/colors.dart';
import 'package:write_me/utils/customWidgets/dialogs/errorEmpty/errorModal.dart';

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
    return Consumer<ListNotesProvider>(
      builder: (context, notesProvider, child) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
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
          onPressed: () async {
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
                notesProvider.addNote(note);
                Navigator.pop(context);
              } else {
                print("Erreur");
              }
            }
          },
          tooltip: 'Enregistrer la note',
          child: const Icon(Icons.save),
        ),
      ),
    );
  }
}
