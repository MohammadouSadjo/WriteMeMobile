import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:write_me/providers/listNotesProvider.dart';
import 'package:write_me/providers/typeNoteProvider.dart';
import 'package:write_me/utils/constants/colors.dart';

import '../errorEmpty/errorModal.dart';
import '../../../constants/textStyleModalTitle.dart';

class ResearchModal extends StatelessWidget {
  final BuildContext context;
  final TextEditingController researchController;

  const ResearchModal(this.context, this.researchController, {super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(
        child: Text(
          'Recherche',
          style: TextStyleModalTitle.style,
        ),
      ),
      content: TextField(
        controller: researchController,
        decoration: const InputDecoration(
          hintText: 'Rechercher...',
        ),
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
        Consumer2<ListNotesProvider, TypeNoteProvider>(
          builder: (context, noteProvider, typenoteProvider, child) =>
              TextButton(
            child: const Text(
              'Rechercher',
              style: TextStyle(
                color: Utils.mainColor,
              ),
            ),
            onPressed: () {
              if (researchController.text == "") {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ErrorModal(context);
                  },
                );
              } else {
                noteProvider.getNotesResearch(researchController.text);
                typenoteProvider.getTypeNotesResearch(researchController.text);
                Navigator.of(context).pop();
                researchController.text = "";
              }
            },
          ),
        )
      ],
    );
  }
}
