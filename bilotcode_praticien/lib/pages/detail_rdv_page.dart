import 'package:flutter/material.dart';

import '../models/rdv.dart';

class DetailRdvPage extends StatefulWidget {
  final Rdv rdv;
  const DetailRdvPage(this.rdv, {super.key});

  @override
  DetailRdvPageState createState() => DetailRdvPageState();
}

class DetailRdvPageState extends State<DetailRdvPage> {
  @override
  Widget build(BuildContext context) {
    final patient = widget.rdv.patient;

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
              'Date: ${widget.rdv.datetime}',
            ),
            Text(
              'Durée: ${widget.rdv.durationMinutes} minutes',
            ),
            Text('Commentaire: ${widget.rdv.commentaire}'),
          ],
        ),
      ),
    );
  }
}
