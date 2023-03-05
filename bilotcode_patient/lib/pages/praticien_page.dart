import 'package:bilotcod_patient/widgets/datepicker.dart';
import 'package:flutter/material.dart';

import '../models/praticien.dart';

class PraticienPage extends StatefulWidget {
  final Praticien praticien;

  const PraticienPage({super.key, required this.praticien});

  @override
  State<PraticienPage> createState() => _PraticienPageState();
}

class _PraticienPageState extends State<PraticienPage> {
  final List<int> durationInMinutesList = [15, 30, 45, 60];
  int? selectedDuration;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Prendre rendez-vous'),
        ),
        body: Center(
          child: Column(
            children: [
              _getPraticienCard(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const MyDatePicker(),
                  const SizedBox(width: 20),
                  _getDurationDropdown(selectedDuration, durationInMinutesList),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Prendre rendez-vous'),
              ),
            ],
          ),
        ));
  }

  DropdownButton<int> _getDurationDropdown(
      int? selectedDuration, List<int> durationInMinutesList) {
    return DropdownButton(
      value: selectedDuration,
      items: durationInMinutesList
          .map((int duration) => DropdownMenuItem(
                value: duration,
                child: Text('$duration minutes'),
              ))
          .toList(),
      onChanged: (int? value) {
        setState(() {
          this.selectedDuration = value!;
        });
      },
      hint: const Text('Durée'),
    );
  }

  Card _getPraticienCard() {
    return Card(
      margin: const EdgeInsets.all(20),
      elevation: 5,
      child: ListTile(
        leading: const Icon(Icons.person),
        title: Text('Dr. ${widget.praticien.nom} ${widget.praticien.prenom}'),
        subtitle: Text(widget.praticien.specialite),
      ),
    );
  }
}
