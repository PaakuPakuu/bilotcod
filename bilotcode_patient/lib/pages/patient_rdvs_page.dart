import 'package:flutter/material.dart';

class PatientRdvsPage extends StatefulWidget {
  const PatientRdvsPage({super.key});

  @override
  State<PatientRdvsPage> createState() => _PatientRdvsPageState();
}

class _PatientRdvsPageState extends State<PatientRdvsPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Rendez-vous',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
