import 'package:bilotcode_praticien/models/praticien.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'models/rdv.dart';

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  final List<Rdv> _rdvs = [];
  final List<Praticien> _praticiens = [];
  bool areRdvsLoading = false;
  bool arePraticiensLoading = true;

  get rdvs => _rdvs;
  get praticiens => _praticiens;
  Praticien? selectedPraticien;

  get selectedPraticienRdvs => selectedPraticien?.rdvs ?? [];

  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    await _loadPraticiens().then((value) async => await loadRdvs());
  }

  /// Charge les rendez-vous du jour du praticien sélectionné
  Future<void> loadRdvs() async {
    areRdvsLoading = true;
    _rdvs.clear();
    notifyListeners();
    await FirebaseFirestore.instance
        .collection('rdvs')
        .where('est_annule', isEqualTo: false)
        .where('datetime',
            // Enlève 1 jour pour s'assurer d'avoir les rdvs du jour (même passés)
            isGreaterThan: Timestamp.fromDate(
                DateTime.now().add(const Duration(days: -1))))
        .get()
        .then((value) async {
      for (var rdvDoc in value.docs) {
        final Rdv rdv = await Rdv.fromFirestore(rdvDoc.id, rdvDoc.data());
        _rdvs.add(rdv);
      }
      areRdvsLoading = false;
      _setPraticiensRdvs();
      //selectedPraticien = _praticiens.last;
      notifyListeners();
    });
  }

  Future<void> _loadPraticiens() async {
    _praticiens.clear();
    await FirebaseFirestore.instance
        .collection('praticiens')
        .get()
        .then((value) async {
      for (var doc in value.docs) {
        final Praticien praticien = Praticien.fromFirestore(doc.id, doc.data());
        _praticiens.add(praticien);
      }
      arePraticiensLoading = false;
      notifyListeners();
    });
  }

  void _setPraticiensRdvs() {
    for (var praticien in _praticiens) {
      praticien.rdvs = _rdvs
          .where((rdv) => rdv.praticien.id == praticien.id)
          .toList(growable: false);
    }
    notifyListeners();
  }

  Future<void> removeRdv(Rdv rdv) async {
    _rdvs.remove(rdv);
    await FirebaseFirestore.instance.collection('rdvs').doc(rdv.id).set({
      'est_annule': true,
    }, SetOptions(merge: true));
    notifyListeners();
  }
}
