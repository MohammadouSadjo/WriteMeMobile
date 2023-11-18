import 'package:flutter/material.dart';
import 'package:write_me/database_helper.dart';
import 'package:write_me/home.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:write_me/note_update.dart';

// ignore: import_of_legacy_library_into_null_safe

class NotePrint extends StatelessWidget {
  const NotePrint(
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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return NotePrintPage(
        title: "Paramètres",
        id: id,
        titre: titre,
        dateCreation: dateCreation,
        dateModification: dateModification,
        texte: texte);
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

class NotePrintPage extends StatefulWidget {
  const NotePrintPage(
      {super.key,
      required this.title,
      required this.id,
      required this.titre,
      required this.dateCreation,
      required this.dateModification,
      required this.texte});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final int id;
  final DateTime dateCreation;
  final DateTime dateModification;
  final String titre;
  final String texte;

  @override
  State<NotePrintPage> createState() => _NotePrintPageState();
}

class _NotePrintPageState extends State<NotePrintPage> {
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
    titreController.text = widget.titre;
    TextEditingController texteController = TextEditingController();
    texteController.text = widget.texte;
    TextEditingController intituledossierController = TextEditingController();

    initializeDateFormatting();
    final DateTime now = DateTime.now();
    String formattedDate = DateFormat("dd MMM", 'fr_FR').format(now);
    String formattedDateYear = DateFormat("y", 'fr_FR').format(now);

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
                //'Jeu 26.04.2023 | 10:34',
                //'Date: ${DateFormat('dd/MM/yyyy').format(_selectedDate)}',
                style: const TextStyle(
                  fontFamily: 'RobotoSlab',
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                  color: Color.fromRGBO(16, 43, 64, 1),
                )),
            const SizedBox(height: 16.0),
            Text(
              widget.titre,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 17.0,
                color: Color.fromRGBO(16, 43, 64, 1),
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
        backgroundColor: const Color.fromRGBO(61, 110, 201, 1.0),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NoteUpdate(
                id: widget.id,
                dateCreation: widget.dateCreation,
                dateModification: widget.dateModification,
                titre: widget.titre,
                texte: widget.texte,
              ),
              //FolderDetailPage(folderData),
            ),
          );
        },
        tooltip: 'Modifier la note',
        child: const Icon(Icons.edit),
      ),
    );
  }
}
