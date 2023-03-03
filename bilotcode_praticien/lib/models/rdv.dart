import 'dart:math';

import 'package:bilotcode_praticien/models/patient.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Rdv {
  String id;
  Patient patient;
  DateTime datetime;
  int dureeMinutes;

  Rdv(this.id, this.patient, this.datetime, this.dureeMinutes);

  static Future<Rdv> fromFirestore(String id, Map<String, dynamic> data) async {
    // random guid string
    final String guid = Random().nextInt(100000).toString();
    final DocumentReference patientRef = data['patient'];
    final DocumentSnapshot<Object?> patientDoc = await patientRef.get();
    final Map<String, dynamic> patientData =
        patientDoc.data() as Map<String, dynamic>;

    return Rdv(
      id,
      Patient.fromFirestore(guid, patientData),
      (data['datetime'] as Timestamp).toDate(),
      data['duree_min'] as int,
    );
  }
}
