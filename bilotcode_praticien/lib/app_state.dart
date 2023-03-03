import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'models/patient.dart';
import 'models/rdv.dart';

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    loadRdvs();
  }

  final List<Rdv> _rdvs = <Rdv>[];

  get rdvs => _rdvs;

  Future<void> loadRdvs() async {
    print('Loading...');
    await FirebaseFirestore.instance.collection('rdvs').get().then((value) {
      _rdvs.clear();
      for (var doc in value.docs) {
        final Rdv rdv = Rdv.fromFirestore(doc.id, doc.data());
        _rdvs.add(rdv);
        print('Document ${doc.id} => ${doc.data()}');
      }
      notifyListeners();
    });

    print('Loaded');
  }

  void removeRdv(Rdv rdv) {
    _rdvs.remove(rdv);
    FirebaseFirestore.instance.collection('rdvs').doc(rdv.id).delete();
  }
}
