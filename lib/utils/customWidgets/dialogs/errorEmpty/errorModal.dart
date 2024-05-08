import 'package:flutter/material.dart';
import 'package:write_me/utils/constants/colors.dart';

import '../../../constants/textStyleModalContent.dart';
import '../../../constants/textStyleModalTitle.dart';

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
