import 'package:flutter/widgets.dart';
import 'package:write_me/database_helper.dart';
import 'package:write_me/models/dto/notesRequest.dart';
import 'package:write_me/models/notes.dart';

class ListNotesProvider extends ChangeNotifier {
  //Future<List<NoteUser>> notes = DatabaseHelper.getNotes();
  List<NoteUser> _allnotes = [];
  List<NoteUser> _allnotesByType = [];
  int _research = 0;

  List<NoteUser> get allnotes => _allnotes;
  List<NoteUser> get allnotesByType => _allnotesByType;
  int get research => _research;

  Future<void> getAllNotes() async {
    List<NoteUser> notes = await DatabaseHelper.getNotes();
    _allnotes = notes;
    _research = 0;
    notifyListeners();
  }

  Future<void> getAllNotesByTypeNote(int id) async {
    List<NoteUser> notes = await DatabaseHelper.getNoteByType(id);
    _allnotesByType = notes;
    _research = 0;
    notifyListeners();
  }

  Future<void> getNotesResearch(String research) async {
    List<NoteUser> notes = await DatabaseHelper.getNotesByResearch(research);
    _allnotes = notes;
    _research = 1;
    notifyListeners();
  }

  Future<void> addNote(NoteUserRequest noteUserRequest) async {
    int id = await DatabaseHelper.createNote(noteUserRequest);

    NoteUser note = NoteUser(
        id_note: id,
        type_note_id: noteUserRequest.type_note_id,
        titre: noteUserRequest.titre,
        texte: noteUserRequest.texte,
        date_creation: noteUserRequest.date_creation,
        date_modification: noteUserRequest.date_modification);
    if (note.type_note_id == 0) {
      _allnotes.add(note);
    } else {
      _allnotesByType.add(note);
    }

    notifyListeners();
  }

  Future<void> updateNote(NoteUser noteUser) async {
    await DatabaseHelper.updateNote(noteUser);
    NoteUser? note;
    int? id_typenote = noteUser.type_note_id;
    if (noteUser.type_note_id == 0) {
      _allnotes = await DatabaseHelper.getNotes();
    } else {
      _allnotes.forEach((element) {
        if (element.id_note == noteUser.id_note) {
          note = element;
        }
      });
      if (note != null) {
        _allnotes.remove(note);
      }

      _allnotesByType = await DatabaseHelper.getNoteByType(id_typenote!);
    }

    notifyListeners();
  }

  Future<void> deleteNote(int id) async {
    await DatabaseHelper.deleteNote(id);
    NoteUser? note;
    note = await DatabaseHelper.getNote(id);
    if (note?.type_note_id == 0) {
      for (var element in _allnotes) {
        if (element.id_note == id) {
          note = element;
        }
      }
      _allnotes.remove(note);
    } else {
      for (var element in _allnotesByType) {
        if (element.id_note == id) {
          note = element;
        }
      }
      _allnotesByType.remove(note);
    }

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
