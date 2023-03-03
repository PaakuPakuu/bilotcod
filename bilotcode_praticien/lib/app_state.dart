import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'models/rdv.dart';

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  final List<Rdv> _rdvs = <Rdv>[];
  bool isDataLoading = false;

  get rdvs => _rdvs;
  get praticien => null;

  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    await loadRdvs();
  }

  /// Charge les rendez-vous du jour
  Future<void> loadRdvs() async {
    isDataLoading = true;
    _rdvs.clear();
    notifyListeners();
    await FirebaseFirestore.instance
        .collection('rdvs')
        .where('datetime',
            // Enlève 1 jour pour assurer d'avoir les rdvs du jour (même passés)
            isGreaterThan: Timestamp.fromDate(
                DateTime.now().add(const Duration(days: -1))))
        .get()
        .then((value) async {
      for (var doc in value.docs) {
        final Rdv rdv = await Rdv.fromFirestore(doc.id, doc.data());
        _rdvs.add(rdv);
      }
      isDataLoading = false;
      notifyListeners();
    });
  }

  Future<void> removeRdv(Rdv rdv) async {
    _rdvs.remove(rdv);
    await FirebaseFirestore.instance.collection('rdvs').doc(rdv.id).set({
      'est_annule': true,
    }, SetOptions(merge: true));
    notifyListeners();
  }
}
