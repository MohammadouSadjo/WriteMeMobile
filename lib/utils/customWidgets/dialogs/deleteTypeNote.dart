import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:write_me/home.dart';
import 'package:write_me/models/notes.dart';
import 'package:write_me/providers/listNotesProvider.dart';
import 'package:write_me/providers/typeNoteProvider.dart';
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
        Consumer2<ListNotesProvider, TypeNoteProvider>(
          builder: (context, notesProvider, typenoteProvider, child) =>
              TextButton(
                  child: const Text(
                    'Confirmer',
                    style: TextStyle(
                      color: Utils.mainColor,
                    ),
                  ),
                  onPressed: () {
                    List<NoteUser> notes = notesProvider.allnotesByType;
                    print("test on pressed");

                    for (var note in notes) {
                      int id_note = note.id_note;
                      notesProvider.deleteNote(id_note);
                    }

                    typenoteProvider.deleteTypeNote(typeNoteId);
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute<void>(
                            builder: (BuildContext context) => const MyApp()),
                        (route) => false);
                    //Navigator.popUntil(context, (route) => route.isFirst);
                  }),
        ),
      ],
    );
  }
}
