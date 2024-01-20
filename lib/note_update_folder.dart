import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:write_me/models/notes.dart';
import 'package:write_me/providers/listNotesProvider.dart';
import 'package:write_me/utils/constants/colors.dart';
import 'package:write_me/utils/customWidgets/dialogs/errorEmpty/errorModal.dart';

class NoteUpdateFolder extends StatelessWidget {
  const NoteUpdateFolder(
      {super.key,
      required this.id,
      required this.dateCreation,
      required this.dateModification,
      required this.titre,
      required this.texte,
      required this.typeNoteId});

  final int id;
  final DateTime dateCreation;
  final DateTime dateModification;
  final String titre;
  final String texte;
  final int typeNoteId;

  @override
  Widget build(BuildContext context) {
    return NoteUpdateFolderPage(
        title: "Paramètres",
        id: id,
        titre: titre,
        dateCreation: dateCreation,
        dateModification: dateModification,
        texte: texte,
        typeNoteId: typeNoteId);
  }
}

class NoteUpdateFolderPage extends StatefulWidget {
  const NoteUpdateFolderPage(
      {super.key,
      required this.title,
      required this.id,
      required this.titre,
      required this.dateCreation,
      required this.dateModification,
      required this.texte,
      required this.typeNoteId});

  final String title;
  final int id;
  final DateTime dateCreation;
  final DateTime dateModification;
  final String titre;
  final String texte;
  final int typeNoteId;

  @override
  State<NoteUpdateFolderPage> createState() => _NoteUpdateFolderPageState();
}

class _NoteUpdateFolderPageState extends State<NoteUpdateFolderPage> {
  String? selectedItem;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController titreController = TextEditingController();
    titreController.text = widget.titre;
    TextEditingController texteController = TextEditingController();
    texteController.text = widget.texte;

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
    return Consumer<ListNotesProvider>(
      builder: (context, notesProvider, child) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(widget.titre),
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
                decoration: const InputDecoration(hintText: 'Titre de la note'),
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

              final dateCreation = widget.dateCreation;
              final dateModification = DateTime.now();
              final typeNoteId = widget.typeNoteId;

              if (titre != "" && texte != "") {
                var noteUpdate = NoteUser(
                    id_note: widget.id,
                    type_note_id: typeNoteId,
                    titre: titre,
                    texte: texte,
                    date_creation: dateCreation,
                    date_modification: dateModification);
                notesProvider.updateNote(noteUpdate);
                Navigator.pop(context);
              } else {
                print("Erreur");
              }
            }
          },
          tooltip: 'Modifier vklhgdfite la note',
          child: const Icon(Icons.save),
        ),
      ),
    );
  }
}
