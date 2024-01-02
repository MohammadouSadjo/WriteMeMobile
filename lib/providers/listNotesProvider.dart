import 'package:flutter/widgets.dart';
import 'package:write_me/database_helper.dart';
import 'package:write_me/models/notes.dart';

class ListNotesProvider extends ChangeNotifier {
  //Future<List<NoteUser>> notes = DatabaseHelper.getNotes();
  List<NoteUser> _allnotes = [];

  List<NoteUser> get allnotes => _allnotes;

  Future<void> getAllNotes() async {
    List<NoteUser> notes = await DatabaseHelper.getNotes();
    _allnotes = notes;
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
