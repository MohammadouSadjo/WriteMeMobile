import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:write_me/models/type_note.dart';
import 'package:write_me/providers/typeNoteProvider.dart';
import 'package:write_me/utils/constants/colors.dart';
import 'package:write_me/utils/constants/textStyleModalTitle.dart';
import 'package:write_me/utils/customWidgets/dialogs/errorEmpty/errorModal.dart';

class RenameTypeNote extends StatelessWidget {
  final BuildContext context;
  final TextEditingController intituletypeController;
  final Type_Note? type_note;
  final int typeNoteId;

  const RenameTypeNote(this.context, this.intituletypeController,
      this.type_note, this.typeNoteId,
      {super.key});

  @override
  Widget build(BuildContext context) {
    intituletypeController.text = type_note!.intitule_type;
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
        Consumer<TypeNoteProvider>(
          builder: (context, typenoteProvider, child) => TextButton(
            child: const Text(
              'Confirmer',
              style: TextStyle(
                color: Utils.mainColor,
              ),
            ),
            onPressed: () async {
              final intitule_type = intituletypeController.text;
              DateTime dateCreationInit = DateTime.now();

              dateCreationInit = type_note!.date_creation;

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
                  typenoteProvider.updateTypeNote(typenoteUpdate);
                  typenoteProvider.getAllTypeNotes();
                  Navigator.of(context).pop();
                } else {
                  print("Erreur");
                }
              }
            },
          ),
        ),
      ],
    );
  }
}
