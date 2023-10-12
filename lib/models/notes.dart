// ignore_for_file: non_constant_identifier_names

class Note {
  final int id_note;
  final int? type_note_id;
  final String titre;
  final String texte;
  final int date_creation;
  final int date_modification;

  Note(
      {required this.id_note,
      required this.type_note_id,
      required this.titre,
      required this.texte,
      required this.date_creation,
      required this.date_modification});

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id_note: map['id_note'],
      type_note_id: map['type_note_id'],
      titre: map['titre'],
      texte: map['texte'],
      date_creation: map['date_creation'],
      date_modification: map['date_modification'],
    );
  }
}
