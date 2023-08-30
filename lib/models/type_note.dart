// ignore_for_file: non_constant_identifier_names, camel_case_types

class Type_Note {
  final int id_type_note;
  final int compte_id;
  final String intitule_type;
  final String date_creation;
  final String date_modification;

  Type_Note(this.date_creation, this.date_modification, this.compte_id,
      this.id_type_note, this.intitule_type);
}
