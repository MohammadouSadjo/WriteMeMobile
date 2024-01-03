import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:write_me/models/dto/type_noteRequest.dart';
import 'package:write_me/providers/typeNoteProvider.dart';
import 'package:write_me/utils/constants/colors.dart';
import 'package:write_me/utils/constants/textStyleModalTitle.dart';
import 'package:write_me/utils/customWidgets/dialogs/errorEmpty/errorModal.dart';

class AddTypeNote extends StatelessWidget {
  final BuildContext context;
  final TextEditingController intituletypeController;

  const AddTypeNote(this.context, this.intituletypeController, {super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(
        child: Text('Nouveau dossier', style: TextStyleModalTitle.style),
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
                hintText: 'Nommez le dossier',
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
        Consumer<TypeNoteProvider>(builder: (context, typenoteProvider, child) {
          return TextButton(
            child: const Text(
              'Confirmer',
              style: TextStyle(
                color: Utils.mainColor,
              ),
            ),
            onPressed: () async {
              final intitule_type = intituletypeController.text;

              final dateCreation = DateTime.now();
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
                  var type_note = Type_NoteRequest(
                      intitule_type: intitule_type,
                      date_creation: dateCreation,
                      date_modification: dateModification);

                  typenoteProvider.addTypeNote(type_note);
                  Navigator.of(context).pop();
                  intituletypeController.text = "";
                  /*final typenoteId =
                      await DatabaseHelper.createTypeNote(type_note);
                  if (typenoteId != 0) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const MyApp(),
                      ),
                      (Route<dynamic> route) => false,
                    );
                  } else {
                    print('Erreur lors de l\'insertion de la note.');
                  }*/
                } else {
                  print("Erreur");
                  intituletypeController.text = "";
                  Navigator.of(context).pop();
                }
              }
            },
          );
        })
      ],
    );
  }
}
