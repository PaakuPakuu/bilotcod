import 'package:flutter/material.dart';

import '../models/rdv.dart';

class DetailRdvPage extends StatelessWidget {
  final Rdv rdv;
  const DetailRdvPage(this.rdv, {super.key});

  @override
  Widget build(BuildContext context) {
    final patient = rdv.patient;

    return Scaffold(
      appBar: AppBar(
          title: Text('${patient.civilite} ${patient.nom} ${patient.prenom}')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Détail du rendez-vous',
            ),
            Text(
              'Patient: ${patient.nom} ${patient.prenom}',
            ),
            Text(
              'Date: ${rdv.datetime}',
            ),
            Text(
              'Durée: ${rdv.durationMinutes} minutes',
            ),
            Text('Commentaire: ${rdv.commentaire}'),
          ],
        ),
      ),
    );
  }
}
