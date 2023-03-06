import 'package:bilotcod_patient/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PatientRdvsPage extends StatefulWidget {
  const PatientRdvsPage({super.key});

  @override
  State<PatientRdvsPage> createState() => _PatientRdvsPageState();
}

class _PatientRdvsPageState extends State<PatientRdvsPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: context.watch<ApplicationState>().loggedIn
            ? const Text(
                'Rendez-vous',
                style: TextStyle(fontSize: 24),
              )
            : const Text(
                'Vous devez être connecté pour accéder à cette page',
                style: TextStyle(fontSize: 24),
              ));
  }
}
