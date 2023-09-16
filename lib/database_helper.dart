import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Future<void> createTables(Database database) async {
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

    await database.execute("""CREATE TABLE notes (
        id_note INTEGER PRIMARY KEY,
        typenote_id INTEGER NOT NULL DEFAULT 0,
        titre TEXT NOT NULL,
        texte TEXT NOT NULL,
        date_creation TEXT NOT NULL,
        date_modification TEXT NOT NULL
      )
      """);

    await database.execute("""CREATE TABLE typenotes (
        id_typenote INTEGER PRIMARY KEY,
        intitule_type TEXT NOT NULL,
        date_creation TEXT NOT NULL,
        date_modification TEXT NOT NULL
      )
      """);
  }

  static Future<Database> db() async {
    return openDatabase(
      'write_me.db',
      version: 1,
      onCreate: (Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> createNote(
      String? titre,
      String? texte,
      String? date_creation,
      String? date_modification,
      int? typenote_id) async {
    final db = await DatabaseHelper.db();

    final data = {
      'titre': titre,
      'texte': texte,
      'date_creation': date_creation,
      'date_modification': date_modification,
      'typenote_id': typenote_id
    };
    final id = await db.insert('notes', data,
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  static Future<int> createTypeNote(String? intitule_type,
      String? date_creation, String? date_modification) async {
    final db = await DatabaseHelper.db();

    final data = {
      'intitule_type': intitule_type,
      'date_creation': date_creation,
      'date_modification': date_modification
    };
    final id = await db.insert('typenotes', data,
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getNotes() async {
    final db = await DatabaseHelper.db();
    print(db.path);
    return db.query('notes', orderBy: "id_note");
  }

  static Future<List<Map<String, dynamic>>> getTypeNotes() async {
    final db = await DatabaseHelper.db();
    return db.query('typenotes', orderBy: "id_typenote");
  }

  static Future<List<Map<String, dynamic>>> getNote(int id) async {
    final db = await DatabaseHelper.db();
    return db.query('notes', where: "id_note = ?", whereArgs: [id], limit: 1);
  }

  static Future<List<Map<String, dynamic>>> getTypeNote(int id) async {
    final db = await DatabaseHelper.db();
    return db.query('typenotes',
        where: "id_typenote = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateNote(
      int id,
      String? titre,
      String? texte,
      String? date_creation,
      String? date_modification,
      int? typenote_id) async {
    final db = await DatabaseHelper.db();

    final data = {
      'titre': titre,
      'texte': texte,
      'date_creation': date_creation,
      'date_modification': date_modification,
      'typenote_id': typenote_id
    };

    final result =
        await db.update('notes', data, where: "id_note = ?", whereArgs: [id]);
    return result;
  }

  static Future<int> updateTypeNote(int id, String? intitule_type,
      String? date_creation, String? date_modification) async {
    final db = await DatabaseHelper.db();

    final data = {
      'intitule_type': intitule_type,
      'date_creation': date_creation,
      'date_modification': date_modification
    };

    final result = await db
        .update('typenotes', data, where: "id_typenote = ?", whereArgs: [id]);
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
      await db.delete("typenotes", where: "id_note = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
