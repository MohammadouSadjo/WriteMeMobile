import 'package:flutter/material.dart';
import 'package:write_me/database_helper.dart';
import 'package:write_me/folder_contain_empty.dart';
import 'package:write_me/models/type_note.dart';
import 'package:write_me/utils/constants/colors.dart';
import 'package:write_me/utils/constants/textStyleModalTitle.dart';
import 'package:write_me/utils/customWidgets/dialogs/errorEmpty/errorModal.dart';

class RenameTypeNote extends StatelessWidget {
  final BuildContext context;
  final TextEditingController intituletypeController;
  final Future<Type_Note?> type_note;
  final int typeNoteId;

  const RenameTypeNote(this.context, this.intituletypeController,
      this.type_note, this.typeNoteId,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(
        child: Text(
          'Renommer le dossier',
          style: TextStyleModalTitle.style,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
            child: TextField(
              controller: intituletypeController,
              style: const TextStyle(
                color: Utils.secondaryColor,
              ),
              decoration: const InputDecoration(
                labelText: 'Nom du dossier',
                labelStyle: TextStyle(
                  color: Utils.secondaryColor,
                ),
                hintText: 'Renommez le dossier',
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
            final intitule_type = intituletypeController.text;
            DateTime dateCreationInit = DateTime.now();
            FutureBuilder<Type_Note?>(
                future: type_note,
                builder: (context, snapshot) {
                  final typeNote = snapshot.data;
                  dateCreationInit = typeNote!.date_creation;
                  return Text(typeNote.date_creation as String);
                });

            final dateCreation = dateCreationInit;
            final dateModification = DateTime.now();

            if (intitule_type == "") {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ErrorModal(context);
                },
              );
            } else {
              if (intitule_type != "") {
                var typenoteUpdate = Type_Note(
                    id_type_note: typeNoteId,
                    intitule_type: intitule_type,
                    date_creation: dateCreation,
                    date_modification: dateModification);
                final typenoteId =
                    await DatabaseHelper.updateTypeNote(typenoteUpdate);
                if (typenoteId != 0) {
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
                } else {
                  print('Erreur lors de l\'insertion de la note.');
                }
              } else {
                print("Erreur");
              }
            }
          },
        ),
      ],
    );
  }
}
