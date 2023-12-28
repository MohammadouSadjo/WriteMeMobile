import 'package:flutter/material.dart';

import '../../../../home_research.dart';
import '../../../colors.dart';
import '../errorEmpty/errorModal.dart';
import '../textStyleModalTitle.dart';

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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyAppResearch(
                    title: 'WriteMe',
                    research: researchController.text,
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
