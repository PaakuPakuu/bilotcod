// ignore_for_file: avoid_print

import 'package:bilotcod_patient/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/patient.dart';
import '../models/rdv.dart';

class AppointmentForm extends StatefulWidget {
  final Rdv rdv;

  const AppointmentForm({super.key, required this.rdv});

  @override
  State<AppointmentForm> createState() => _AppointmentFormState();
}

class _AppointmentFormState extends State<AppointmentForm> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedSexe;
  String? _name;
  String? _firstName;
  int? _age;
  String? _comment;

  final List<String> _sexes = ['Homme', 'Femme', 'Autre'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vos informations'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              if (context.watch<ApplicationState>().loggedIn)
                _getLoggedInPatientCard(),
              context.watch<ApplicationState>().loggedIn
                  ? _getLoggedInForm()
                  : _getNotLoggedInForm(),
            ],
          ),
        ),
      ),
    );
  }

  Card _getLoggedInPatientCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text('Vous êtes connecté en tant que'),
            const SizedBox(height: 20),
            Text(
              'Nom: ${context.watch<ApplicationState>().user!.displayName}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'Email: ${context.watch<ApplicationState>().user!.email}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Form _getNotLoggedInForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 20),
          const Text('Sexe'),
          DropdownButtonFormField(
            value: _selectedSexe,
            items: _sexes.map((sexe) {
              return DropdownMenuItem(
                value: sexe,
                child: Text(sexe),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                _selectedSexe = newValue!;
              });
            },
            validator: (value) {
              if (value == null) {
                return 'Veuillez sélectionner votre sexe';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          const Text('Nom'),
          TextFormField(
            onChanged: (value) {
              setState(() {
                _name = value;
              });
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'Veuillez entrer votre nom';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          const Text('Prénom'),
          TextFormField(
            onChanged: (value) {
              setState(() {
                _firstName = value;
              });
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'Veuillez entrer votre prénom';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          const Text('Âge'),
          TextFormField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                _age = int.tryParse(value) ?? 0;
              });
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'Veuillez entrer votre âge';
              }
              if (int.tryParse(value) == null) {
                return 'Veuillez entrer un nombre';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          const Text('Commentaire'),
          TextFormField(
            onChanged: (value) {
              setState(() {
                _comment = value;
              });
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'Veuillez entrer votre commentaire';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: _validateAndSend,
              child: const Text('Prendre rendez-vous',
                  style: TextStyle(fontSize: 20)),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _validateAndSend() async {
    if (_formKey.currentState?.validate() ?? false) {
      final patient = Patient(_name!, _firstName!, _age!, _selectedSexe!);
      widget.rdv.commentaire = _comment;

      final appState = context.read<ApplicationState>();
      String newPatientId = await appState.addPatient(patient);
      patient.id = newPatientId;
      widget.rdv.patient = patient;
      await appState.addRdv(widget.rdv);

      Navigator.of(_formKey.currentContext!).pop();
    }
  }

  Form _getLoggedInForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 20),
          const Text('Commentaire'),
          TextFormField(
            onChanged: (value) {
              setState(() {
                _comment = value;
              });
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'Veuillez entrer votre commentaire';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  // Envoyer les données du formulaire
                  print('Commentaire: $_comment');
                }
              },
              child: const Text('Prendre rendez-vous'),
            ),
          ),
        ],
      ),
    );
  }
}
