import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:write_me/note_update_folder.dart';
import 'package:write_me/utils/constants/colors.dart';

class NotePrintFolder extends StatelessWidget {
  const NotePrintFolder(
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
    return NotePrintFolderPage(
        title: "Paramètres",
        id: id,
        titre: titre,
        dateCreation: dateCreation,
        dateModification: dateModification,
        texte: texte,
        typeNoteId: typeNoteId);
  }
}

class NotePrintFolderPage extends StatefulWidget {
  const NotePrintFolderPage(
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
  State<NotePrintFolderPage> createState() => _NotePrintFolderPageState();
}

class _NotePrintFolderPageState extends State<NotePrintFolderPage> {
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.titre,
          style: const TextStyle(color: Colors.white),
        ),
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
            Text(
              widget.titre,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 17.0,
                color: Utils.secondaryColor,
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: Text(
                widget.texte,
                maxLines: null,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Utils.mainColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NoteUpdateFolder(
                id: widget.id,
                dateCreation: widget.dateCreation,
                dateModification: widget.dateModification,
                titre: widget.titre,
                texte: widget.texte,
                typeNoteId: widget.typeNoteId,
              ),
            ),
          );
        },
        tooltip: 'Modifier la note',
        child: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
    );
  }
}
