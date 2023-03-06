import 'package:bilotcod_patient/models/rdv.dart';

class Praticien {
  String id;
  String nom;
  String prenom;
  String specialite;
  List<Rdv> rdvs = [];

  Praticien(this.id, this.nom, this.prenom, this.specialite);

  factory Praticien.fromFirestore(String id, Map<String, dynamic> data) {
    return Praticien(
      id,
      data['nom'] as String,
      data['prenom'] as String,
      data['specialite'] as String,
    );
  }
}
