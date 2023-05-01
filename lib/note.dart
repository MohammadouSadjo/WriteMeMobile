import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
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
            const Text('Date : 26/04/2023',
                //'Date: ${DateFormat('dd/MM/yyyy').format(_selectedDate)}',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15.0,
                  color: Color.fromRGBO(16, 43, 64, 1),
                )),
            const SizedBox(height: 16.0),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Titre de la note',
                //border: OutlineInputBorder(),
              ),
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
        onPressed: () {
          // Enregistrer la note ici
          Navigator.pop(context);
        },
        tooltip: 'Enregistrer la note',
        child: const Icon(Icons.save),
      ),
    );
  }
}
