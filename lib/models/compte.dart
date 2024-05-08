// ignore_for_file: non_constant_identifier_names

class Compte {
  final int id_compte;
  final String pseudo;
  final String mot_de_passe;
  final String e_mail;
  final String telephone;
  final String nom;
  final String prenom;
  final String date_naissance;
  final String statut;
  final String date_creation;
  final String date_modification;

  Compte(
      this.id_compte,
      this.pseudo,
      this.mot_de_passe,
      this.e_mail,
      this.telephone,
      this.nom,
      this.prenom,
      this.date_naissance,
      this.statut,
      this.date_creation,
      this.date_modification);
}
