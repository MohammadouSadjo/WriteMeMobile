// ignore_for_file: non_constant_identifier_names

class Note {
  final int id_note;
  final int compte_id;
  final int type_note_id;
  final String titre;
  final String texte;
  final String date_creation;
  final String date_modification;

  Note(this.date_creation, this.date_modification, this.id_note, this.compte_id,
      this.type_note_id, this.titre, this.texte);
}
