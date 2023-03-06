import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'models/patient.dart';
import 'models/praticien.dart';
import 'models/rdv.dart';

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

  get user => null;

  final List<Praticien> _praticiens = [];
  List<Praticien> get praticiens => _praticiens;
  bool arePraticiensLoading = true;

  final List<Rdv> _rdvs = [];
  List<Rdv> get rdvs => _rdvs;
  bool areRdvsLoading = true;

  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    // Firebase auth
    FirebaseUIAuth.configureProviders([
      EmailAuthProvider(),
    ]);

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loggedIn = true;
      } else {
        _loggedIn = false;
      }
      notifyListeners();
    });

    // Firebase firestore
    await _loadPraticiens().then((value) async => await loadRdvs());
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

  void _setPraticiensRdvs() {
    for (var praticien in _praticiens) {
      praticien.rdvs = _rdvs
          .where((rdv) => rdv.praticien.id == praticien.id)
          .toList(growable: false);
    }
    notifyListeners();
  }

  Future<void> addRdv(Rdv rdv) async {
    await FirebaseFirestore.instance.collection('rdvs').add({
      'commentaire': rdv.commentaire,
      'datetime': rdv.datetime,
      'duree_min': rdv.durationMinutes,
      'est_annule': rdv.isCancelled,
      'patient': 'patients/${rdv.patient?.id}',
      'praticien': 'praticiens/${rdv.praticien.id}',
    });
  }

  Future<void> cancelRdv(Rdv rdv) async {
    await FirebaseFirestore.instance
        .collection('rdvs')
        .doc(rdv.id)
        .update({'est_annule': true});
  }

  Future<String> addPatient(Patient patient) async {
    return await FirebaseFirestore.instance.collection('patients').add({
      'nom': patient.nom,
      'prenom': patient.prenom,
      'sexe': patient.sexe,
      'age': patient.age,
    }).then((value) => value.id);
  }
}
