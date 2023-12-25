import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:write_me/utils/colors.dart';

import '../../database_helper.dart';
import '../../folder_contain_empty.dart';
import '../../note_print_folder.dart';
import '../../note_update_folder.dart';

class MyListTileFolder extends StatelessWidget {
  final int id;
  final DateTime dateCreation;
  final DateTime dateModification;
  final String titre;
  final String texte;
  final int typeNoteId;

  const MyListTileFolder(
      {super.key,
      required this.id,
      required this.dateCreation,
      required this.dateModification,
      required this.titre,
      required this.texte,
      required this.typeNoteId});

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
            builder: (context) => NotePrintFolder(
              id: id,
              dateCreation: dateCreation,
              dateModification: dateModification,
              titre: titre,
              texte: texte,
              typeNoteId: typeNoteId,
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
                    builder: (context) => NoteUpdateFolder(
                      id: id,
                      dateCreation: dateCreation,
                      dateModification: dateModification,
                      titre: titre,
                      texte: texte,
                      typeNoteId: typeNoteId,
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
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20.0,
                            color: Utils.mainColor,
                          ),
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
                              style: TextStyle(
                                color: Utils.secondaryColor,
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
                              color: Utils.mainColor,
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
                                color: Utils.mainColor,
                              ),
                            ),
                            onPressed: () async {
                              await DatabaseHelper.deleteNote(id);
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => FolderContainEmpty(
                                    id: typeNoteId,
                                    title: '',
                                  ),
                                ),
                                (Route<dynamic> route) => false,
                              );
                            }),
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
