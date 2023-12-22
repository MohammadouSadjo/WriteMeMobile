// ignore_for_file: non_constant_identifier_names, camel_case_types

class Type_NoteRequest {
  String intitule_type;
  DateTime date_creation;
  DateTime date_modification;

  Type_NoteRequest({
    required this.intitule_type,
    required this.date_creation,
    required this.date_modification,
  });

  Map<String, dynamic> toMap() {
    return {
      'intitule_type': intitule_type,
      'date_creation': date_creation.millisecondsSinceEpoch,
      'date_modification': date_modification.millisecondsSinceEpoch,
    };
  }

  factory Type_NoteRequest.fromMap(Map<String, dynamic> map) {
    return Type_NoteRequest(
      intitule_type: map['intitule_type'],
      date_creation: map['date_creation'],
      date_modification: map['date_modification'],
    );
  }
}
