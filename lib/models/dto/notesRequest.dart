// ignore_for_file: non_constant_identifier_names

class NoteUserRequest {
  int? type_note_id;
  String titre;
  String texte;
  DateTime date_creation;
  DateTime date_modification;

  NoteUserRequest(
      {required this.type_note_id,
      required this.titre,
      required this.texte,
      required this.date_creation,
      required this.date_modification});

  Map<String, dynamic> toMap() {
    return {
      'typenote_id': type_note_id,
      'titre': titre,
      'texte': texte,
      'date_creation': date_creation.millisecondsSinceEpoch,
      'date_modification': date_modification.millisecondsSinceEpoch,
    };
  }

  factory NoteUserRequest.fromMap(Map<String, dynamic> map) {
    return NoteUserRequest(
      type_note_id: map['type_note_id'],
      titre: map['titre'],
      texte: map['texte'],
      date_creation: map['date_creation'],
      date_modification: map['date_modification'],
    );
  }
}
