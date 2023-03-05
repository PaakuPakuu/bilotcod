import 'package:bilotcode_praticien/models/patient.dart';
import 'package:bilotcode_praticien/models/praticien.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Rdv {
  String id;
  Patient patient;
  Praticien praticien;
  DateTime datetime;
  int durationMinutes;
  bool isCancelled;
  String commentaire;

  get isToday => datetime.day == DateTime.now().day;

  Rdv(this.id, this.patient, this.praticien, this.datetime,
      this.durationMinutes, this.isCancelled, this.commentaire);

  static Future<Rdv> fromFirestore(String id, Map<String, dynamic> data) async {
    final DocumentReference patientRef = data['patient'];
    final DocumentSnapshot<Object?> patientDoc = await patientRef.get();
    final Map<String, dynamic> patientData =
        patientDoc.data() as Map<String, dynamic>;

    final DocumentReference praticienRef = data['praticien'];
    final DocumentSnapshot<Object?> praticienDoc = await praticienRef.get();
    final Map<String, dynamic> praticienData =
        praticienDoc.data() as Map<String, dynamic>;

    return Rdv(
      id,
      Patient.fromFirestore(patientDoc.id, patientData),
      Praticien.fromFirestore(praticienDoc.id, praticienData),
      (data['datetime'] as Timestamp).toDate(),
      data['duree_min'] as int,
      data['est_annule'] as bool,
      data['commentaire'] as String,
    );
  }
}
