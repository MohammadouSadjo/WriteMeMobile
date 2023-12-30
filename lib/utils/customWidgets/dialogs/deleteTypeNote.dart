import 'package:flutter/material.dart';
import 'package:write_me/database_helper.dart';
import 'package:write_me/home.dart';
import 'package:write_me/models/notes.dart';
import 'package:write_me/utils/constants/colors.dart';
import 'package:write_me/utils/constants/textStyleModalContent.dart';
import 'package:write_me/utils/constants/textStyleModalTitle.dart';

class DeleteTypeNote extends StatelessWidget {
  final BuildContext context;
  final Future<List<NoteUser>> _notes;
  final int typeNoteId;

  const DeleteTypeNote(this.context, this._notes, this.typeNoteId, {super.key});

  @override
  Widget build(BuildContext context) {
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
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 15),
            child: Text(
              "Etes-vous sûr de vouloir supprimer ce dossier et toutes ses notes?",
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
        TextButton(
            child: const Text(
              'Confirmer',
              style: TextStyle(
                color: Utils.mainColor,
              ),
            ),
            onPressed: () async {
              FutureBuilder<List<NoteUser>>(
                  future: _notes,
                  builder: (context, snapshot) {
                    final notes = snapshot.data;

                    notes!.map((note) async {
                      int id_note = note.id_note;
                      await DatabaseHelper.deleteNote(id_note);
                    });
                    return const Text("");
                  });

              await DatabaseHelper.deleteTypeNote(typeNoteId);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => const MyApp(),
                ),
                (Route<dynamic> route) => false,
              );
            }),
      ],
    );
  }
}
