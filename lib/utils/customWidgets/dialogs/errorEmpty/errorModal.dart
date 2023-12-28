import 'package:flutter/material.dart';

import '../../../colors.dart';
import '../textStyleModalContent.dart';
import '../textStyleModalTitle.dart';

class ErrorModal extends StatelessWidget {
  final BuildContext context;

  const ErrorModal(this.context);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(
        child: Text(
          'Erreur',
          style: TextStyleModalTitle.style,
        ),
      ),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 15),
            child: Text(
              'Zone de texte vide!',
              style: TextStyleModalContent.style,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text(
            'Fermer',
            style: TextStyle(
              color: Utils.mainColor,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
