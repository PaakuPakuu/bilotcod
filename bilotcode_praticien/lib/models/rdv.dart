import 'dart:math';

import 'package:bilotcode_praticien/models/patient.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Rdv {
  String id;
  Patient patient;
  DateTime datetime;
  int dureeMinutes;

  Rdv(this.id, this.patient, this.datetime, this.dureeMinutes);

  factory Rdv.fromFirestore(String id, Map<String, dynamic> data) {
    // random guid string
    final String guid = Random().nextInt(100000).toString();

    return Rdv(
      id,
      Patient.fromFirestore(guid, data['patient']),
      (data['datetime'] as Timestamp).toDate(),
      data['duree_min'] as int,
    );
  }
}
