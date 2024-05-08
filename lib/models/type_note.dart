// ignore_for_file: non_constant_identifier_names, camel_case_types

class Type_Note {
  int id_type_note;
  String intitule_type;
  DateTime date_creation;
  DateTime date_modification;

  Type_Note({
    required this.id_type_note,
    required this.intitule_type,
    required this.date_creation,
    required this.date_modification,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_typenote': id_type_note,
      'intitule_type': intitule_type,
      'date_creation': date_creation.millisecondsSinceEpoch,
      'date_modification': date_modification.millisecondsSinceEpoch,
    };
  }

  factory Type_Note.fromMap(Map<String, dynamic> map) {
    return Type_Note(
      id_type_note: map['id_typenote'],
      intitule_type: map['intitule_type'],
      date_creation: map['date_creation'],
      date_modification: map['date_modification'],
    );
  }
}
