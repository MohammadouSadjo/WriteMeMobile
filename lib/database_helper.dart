import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:write_me/models/dto/notesRequest.dart';
import 'package:write_me/models/dto/type_noteRequest.dart';
import 'package:write_me/models/type_note.dart';

import 'models/notes.dart';

class DatabaseHelper {
  static void createTables(Database database) {
    /*await database.execute("""CREATE TABLE comptes (
        id_compte INTEGER PRIMARY KEY,
        pseudo TEXT NOT NULL,
        mot_de_passe TEXT NOT NULL,
        e_mail TEXT NOT NULL,
        telephone TEXT NOT NULL,
        nom TEXT NOT NULL,
        prenom TEXT NOT NULL,
        date_naissance TEXT NOT NULL,
        statut TEXT NOT NULL,
        date_creation TEXT NOT NULL,
        date_modification TEXT NOT NULL,
        code_inscription TEXT,
        date_code_mdp TEXT NOT NULL,
        code_mot_de_passe_oublie TEXT
      )
      """);*/
    database.execute("DROP TABLE IF EXISTS notes");
    database.execute("DROP TABLE IF EXISTS typenotes");

    database.execute("""CREATE TABLE notes (
        id_note INTEGER PRIMARY KEY,
        typenote_id INTEGER NOT NULL DEFAULT 0,
        titre TEXT NOT NULL,
        texte TEXT NOT NULL,
        date_creation INTEGER NOT NULL DEFAULT (CAST(strftime('%s', 'now') AS INTEGER)),
        date_modification INTEGER NOT NULL DEFAULT (CAST(strftime('%s', 'now') AS INTEGER))
      )
      """);

    database.execute("""CREATE TABLE typenotes (
        id_typenote INTEGER PRIMARY KEY,
        intitule_type TEXT NOT NULL,
        date_creation INTEGER NOT NULL DEFAULT (CAST(strftime('%s', 'now') AS INTEGER)),
        date_modification INTEGER NOT NULL DEFAULT (CAST(strftime('%s', 'now') AS INTEGER))
      )
      """);
  }

  static Future<Database> db() async {
    //databaseFactory.deleteDatabase(
    //"/data/user/0/com.example.write_me/databases/write_me.db");

    return openDatabase(
      'write_me.db',
      version: 1,
      onCreate: (Database database, int version) async {
        createTables(database);
      },
    );
  }

  static Future<int> createNote(NoteUserRequest note) async {
    final db = await DatabaseHelper.db();

    final id = await db.insert('notes', note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  static Future<int> createTypeNote(Type_NoteRequest type_note) async {
    final db = await DatabaseHelper.db();

    final id = await db.insert('typenotes', type_note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<NoteUser>> getNotes() async {
    final db = await DatabaseHelper.db();
    print(db.path);
    final List<Map<String, dynamic>> maps =
        await db.query('notes', orderBy: "id_note", where: "typenote_id = 0");

    return List.generate(maps.length, (i) {
      return NoteUser(
          id_note: maps[i]['id_note'] as int,
          type_note_id: maps[i]['typenote_id'] as int,
          titre: maps[i]['titre'] as String,
          texte: maps[i]['texte'] as String,
          date_creation:
              DateTime.fromMillisecondsSinceEpoch(maps[i]['date_creation']),
          date_modification: DateTime.fromMillisecondsSinceEpoch(
              maps[i]['date_modification']));
    });
    //return db.query('notes', orderBy: "id_note", where: "typenote_id = 0");
  }

  static Future<List<NoteUser>> getNotesByResearch(String searchQuery) async {
    final db = await DatabaseHelper.db();
    print(db.path);

    String whereClause = "typenote_id = 0";

    if (searchQuery != "" && searchQuery.isNotEmpty) {
      whereClause +=
          " AND (titre LIKE '%$searchQuery%' OR texte LIKE '%$searchQuery%')";
    }
    final List<Map<String, dynamic>> maps =
        await db.query('notes', orderBy: "id_note", where: whereClause);

    return List.generate(maps.length, (i) {
      return NoteUser(
          id_note: maps[i]['id_note'] as int,
          type_note_id: maps[i]['typenote_id'] as int,
          titre: maps[i]['titre'] as String,
          texte: maps[i]['texte'] as String,
          date_creation:
              DateTime.fromMillisecondsSinceEpoch(maps[i]['date_creation']),
          date_modification: DateTime.fromMillisecondsSinceEpoch(
              maps[i]['date_modification']));
    });
  }

  static Future<List<Type_Note>> getTypeNotes() async {
    final db = await DatabaseHelper.db();

    final List<Map<String, dynamic>> maps =
        await db.query('typenotes', orderBy: "id_typenote");

    return List.generate(maps.length, (i) {
      return Type_Note(
          id_type_note: maps[i]['id_typenote'] as int,
          intitule_type: maps[i]['intitule_type'] as String,
          date_creation:
              DateTime.fromMillisecondsSinceEpoch(maps[i]['date_creation']),
          date_modification: DateTime.fromMillisecondsSinceEpoch(
              maps[i]['date_modification']));
    });
    //return db.query('typenotes', orderBy: "id_typenote");
  }

  static Future<List<Type_Note>> getTypeNotesByResearch(
      String searchQuery) async {
    final db = await DatabaseHelper.db();
    print(db.path);

    String whereClause = "intitule_type LIKE '%$searchQuery%'";

    /*final List<Map<String, dynamic>> maps =
        await db.query('typenotes', orderBy: "id_typenote", where: whereClause);*/

    final List<Map<String, dynamic>> maps = await db.rawQuery('''
    SELECT typenotes.id_typenote, typenotes.intitule_type, 
           typenotes.date_creation, typenotes.date_modification
    FROM typenotes
    LEFT JOIN notes ON typenotes.id_typenote = notes.typenote_id
    WHERE typenotes.intitule_type LIKE '%$searchQuery%'
       OR notes.titre LIKE '%$searchQuery%' OR notes.texte LIKE '%$searchQuery%'
    GROUP BY typenotes.id_typenote ORDER BY typenotes.id_typenote
  ''');

    return List.generate(maps.length, (i) {
      return Type_Note(
          id_type_note: maps[i]['id_typenote'] as int,
          intitule_type: maps[i]['intitule_type'] as String,
          date_creation:
              DateTime.fromMillisecondsSinceEpoch(maps[i]['date_creation']),
          date_modification: DateTime.fromMillisecondsSinceEpoch(
              maps[i]['date_modification']));
    });
  }

  static Future<NoteUser?> getNote(int id) async {
    final db = await DatabaseHelper.db();

    List<Map<String, dynamic>> result = await db.query('notes',
        where: "id_note = ?", whereArgs: [id], limit: 1);

    if (result.isNotEmpty) {
      return NoteUser(
        id_note: result.first['id_note'] as int,
        type_note_id: result.first['typenote_id'] as int,
        titre: result.first['titre'] as String,
        texte: result.first['texte'] as String,
        date_creation:
            DateTime.fromMillisecondsSinceEpoch(result.first['date_creation']),
        date_modification: DateTime.fromMillisecondsSinceEpoch(
            result.first['date_modification']),
      );
    } else {
      return null;
    }
    //return db.query('notes', where: "id_note = ?", whereArgs: [id], limit: 1);
  }

  static Future<List<NoteUser>> getNoteByType(int id) async {
    final db = await DatabaseHelper.db();

    final List<Map<String, dynamic>> maps = await db.query('notes',
        orderBy: "id_note", where: "typenote_id = ?", whereArgs: [id]);

    return List.generate(maps.length, (i) {
      return NoteUser(
          id_note: maps[i]['id_note'] as int,
          type_note_id: maps[i]['typenote_id'] as int,
          titre: maps[i]['titre'] as String,
          texte: maps[i]['texte'] as String,
          date_creation:
              DateTime.fromMillisecondsSinceEpoch(maps[i]['date_creation']),
          date_modification: DateTime.fromMillisecondsSinceEpoch(
              maps[i]['date_modification']));
    });
    //return db.query('notes', where: "typenote_id = ?", whereArgs: [id]);
  }

  static Future<Type_Note?> getTypeNote(int id) async {
    final db = await DatabaseHelper.db();

    List<Map<String, dynamic>> result = await db.query('typenotes',
        where: "id_typenote = ?", whereArgs: [id], limit: 1);

    if (result.isNotEmpty) {
      return Type_Note(
        id_type_note: result.first['id_typenote'] as int,
        intitule_type: result.first['intitule_type'] as String,
        date_creation:
            DateTime.fromMillisecondsSinceEpoch(result.first['date_creation']),
        date_modification: DateTime.fromMillisecondsSinceEpoch(
            result.first['date_modification']),
      );
    } else {
      return null;
    }

    //return db.query('typenotes',
    //  where: "id_typenote = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateNote(NoteUser user) async {
    final db = await DatabaseHelper.db();

    final result = await db.update('notes', user.toMap(),
        where: "id_note = ?", whereArgs: [user.id_note]);
    return result;
  }

  static Future<int> updateTypeNote(Type_Note type_note) async {
    final db = await DatabaseHelper.db();

    final result = await db.update('typenotes', type_note.toMap(),
        where: "id_typenote = ?", whereArgs: [type_note.id_type_note]);
    return result;
  }

  static Future<void> deleteNote(int id) async {
    final db = await DatabaseHelper.db();
    try {
      await db.delete("notes", where: "id_note = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  static Future<void> deleteTypeNote(int id) async {
    final db = await DatabaseHelper.db();
    try {
      await db.delete("typenotes", where: "id_typenote = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
