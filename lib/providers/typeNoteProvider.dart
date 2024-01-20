import 'package:flutter/material.dart';
import 'package:write_me/database_helper.dart';
import 'package:write_me/models/dto/type_noteRequest.dart';
import 'package:write_me/models/type_note.dart';

class TypeNoteProvider extends ChangeNotifier {
  List<Type_Note> _alltypeNotes = [];

  List<Type_Note> get alltypeNote => _alltypeNotes;

  Future<void> getAllTypeNotes() async {
    List<Type_Note> notes = await DatabaseHelper.getTypeNotes();
    _alltypeNotes = notes;
    notifyListeners();
  }

  Future<void> getTypeNote(int id) async {
    Type_Note? type_note = await DatabaseHelper.getTypeNote(id);
  }

  Future<void> getTypeNotesResearch(String research) async {
    List<Type_Note> notes =
        await DatabaseHelper.getTypeNotesByResearch(research);
    _alltypeNotes = notes;
    //_research = 1;
    notifyListeners();
  }

  Future<int> addTypeNote(Type_NoteRequest typenote) async {
    int id = await DatabaseHelper.createTypeNote(typenote);
    Type_Note _typenote = Type_Note(
        id_type_note: id,
        intitule_type: typenote.intitule_type,
        date_creation: typenote.date_creation,
        date_modification: typenote.date_modification);

    _alltypeNotes.add(_typenote);
    notifyListeners();
    return id;
  }
}
