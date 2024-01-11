import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:write_me/providers/listNotesProvider.dart';
import 'package:write_me/utils/constants/colors.dart';

import '../../note_print.dart';
import '../../note_update.dart';
import '../constants/textStyleModalTitle.dart';
import '../constants/textStyleModalContent.dart';

class MyListTile extends StatelessWidget {
  final int id;
  final DateTime dateCreation;
  final DateTime dateModification;
  final String titre;
  final String texte;

  const MyListTile(
      {super.key,
      required this.id,
      required this.dateCreation,
      required this.dateModification,
      required this.titre,
      required this.texte});

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();

    String formattedDate =
        DateFormat("dd MMM", 'fr_FR').format(dateModification);
    String formattedDateYear =
        DateFormat("y", 'fr_FR').format(dateModification);

    String dateTime = formattedDate + "\n" + formattedDateYear;

    String formattedTime =
        DateFormat('HH:mm', 'fr_FR').format(dateModification);
    String truncatedText = "";
    if (texte.length > 60) {
      truncatedText = texte.substring(0, 60);
      truncatedText += "...";
    } else {
      truncatedText = texte;
    }

    return ListTile(
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            dateTime,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: Utils.secondaryColorMidOpacity,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 5),
            height: double.infinity,
            width: 3,
            decoration: const BoxDecoration(
              color: Utils.secondaryColorMidOpacity,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
          ),
        ],
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            formattedTime,
            style: const TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 10,
            ),
          ),
          Text(
            titre,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          ),
        ],
      ),
      subtitle: Text(
        truncatedText,
        style: const TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 12,
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NotePrint(
              id: id,
              dateCreation: dateCreation,
              dateModification: dateModification,
              titre: titre,
              texte: texte,
            ),
          ),
        );
      },
      trailing: PopupMenuButton<String>(
        itemBuilder: (BuildContext context) {
          return <PopupMenuEntry<String>>[
            PopupMenuItem<String>(
              value: 'edit',
              child: const Row(
                children: <Widget>[
                  Icon(
                    Icons.edit,
                    color: Utils.secondaryColor,
                  ),
                  Text(
                    '  Modifier',
                    style: TextStyle(
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NoteUpdate(
                      id: id,
                      dateCreation: dateCreation,
                      dateModification: dateModification,
                      titre: titre,
                      texte: texte,
                    ),
                  ),
                );
              },
            ),
            PopupMenuItem<String>(
              value: 'delete',
              child: const Row(
                children: <Widget>[
                  Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  Text(
                    '  Supprimer',
                    style: TextStyle(
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Center(
                        child: Text(
                          'Suppression',
                          style: TextStyleModalTitle.style,
                        ),
                      ),
                      content: const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: 10, right: 10, bottom: 15),
                            child: Text(
                              "Etes-vous sûr de vouloir supprimer cette note?",
                              style: TextStyleModalContent.style,
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          child: const Text(
                            'Annuler',
                            style: TextStyle(
                              color: Utils.mainColor,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        Consumer<ListNotesProvider>(
                          builder: (context, notesProvider, child) =>
                              TextButton(
                                  child: const Text(
                                    'Confirmer',
                                    style: TextStyle(
                                      color: Utils.mainColor,
                                    ),
                                  ),
                                  onPressed: () async {
                                    notesProvider.deleteNote(id);

                                    Navigator.of(context).pop();
                                  }),
                        )
                      ],
                    );
                  },
                );
              },
            ),
          ];
        },
      ),
    );
  }
}
