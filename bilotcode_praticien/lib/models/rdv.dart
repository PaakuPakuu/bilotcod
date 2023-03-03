import 'package:bilotcode_praticien/models/patient.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Rdv {
  String id;
  Patient patient;
  DateTime datetime;
  int dureeMinutes;
  bool isCancelled;

  Rdv(this.id, this.patient, this.datetime, this.dureeMinutes,
      this.isCancelled);

  static Future<Rdv> fromFirestore(String id, Map<String, dynamic> data) async {
    final DocumentReference patientRef = data['patient'];
    final DocumentSnapshot<Object?> patientDoc = await patientRef.get();
    final Map<String, dynamic> patientData =
        patientDoc.data() as Map<String, dynamic>;

    return Rdv(
      id,
      Patient.fromFirestore(patientDoc.id, patientData),
      (data['datetime'] as Timestamp).toDate(),
      data['duree_min'] as int,
      data['est_annule'] as bool,
    );
  }
}
