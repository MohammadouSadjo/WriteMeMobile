// ignore_for_file: non_constant_identifier_names, camel_case_types

class Type_Note {
  final int id_type_note;
  final String intitule_type;
  final int date_creation;
  final int date_modification;

  Type_Note({
    required this.id_type_note,
    required this.intitule_type,
    required this.date_creation,
    required this.date_modification,
  });

  factory Type_Note.fromMap(Map<String, dynamic> map) {
    return Type_Note(
      id_type_note: map['id_type_note'],
      intitule_type: map['intitule_type'],
      date_creation: map['date_creation'],
      date_modification: map['date_modification'],
    );
  }
}
