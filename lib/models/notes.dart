// ignore_for_file: non_constant_identifier_names

class NoteUser {
  int id_note;
  int? type_note_id;
  String titre;
  String texte;
  DateTime date_creation;
  DateTime date_modification;

  NoteUser(
      {required this.id_note,
      required this.type_note_id,
      required this.titre,
      required this.texte,
      required this.date_creation,
      required this.date_modification});

  Map<String, dynamic> toMap() {
    return {
      'id_note': id_note,
      'typenote_id': type_note_id,
      'titre': titre,
      'texte': texte,
      'date_creation': date_creation.millisecondsSinceEpoch,
      'date_modification': date_modification.millisecondsSinceEpoch,
    };
  }

  factory NoteUser.fromMap(Map<String, dynamic> map) {
    return NoteUser(
      id_note: map['id_note'],
      type_note_id: map['type_note_id'],
      titre: map['titre'],
      texte: map['texte'],
      date_creation: map['date_creation'],
      date_modification: map['date_modification'],
    );
  }
}
