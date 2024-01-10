import 'package:flutter/widgets.dart';
import 'package:write_me/database_helper.dart';
import 'package:write_me/models/notes.dart';

class ListNotesProvider extends ChangeNotifier {
  //Future<List<NoteUser>> notes = DatabaseHelper.getNotes();
  List<NoteUser> _allnotes = [];
  int _research = 0;

  List<NoteUser> get allnotes => _allnotes;
  int get research => _research;

  Future<void> getAllNotes() async {
    List<NoteUser> notes = await DatabaseHelper.getNotes();
    _allnotes = notes;
    _research = 0;
    notifyListeners();
  }

  Future<void> getNotesResearch(String research) async {
    List<NoteUser> notes = await DatabaseHelper.getNotesByResearch(research);
    _allnotes = notes;
    _research = 1;
    notifyListeners();
  }
  /*List<NoteUser> getNotes() {
    List<NoteUser> result = [];
    notes.then((value) {
      result = value;
    });
    //notifyListeners();
    return result;
  }*/
}
