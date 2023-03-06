import 'package:flutter/material.dart';

import '../models/praticien.dart';
import '../models/rdv.dart';
import '../widgets/datepicker.dart';
import 'rdv_form.dart';

class PraticienPage extends StatefulWidget {
  final Praticien praticien;

  const PraticienPage({super.key, required this.praticien});

  @override
  State<PraticienPage> createState() => _PraticienPageState();
}

class _PraticienPageState extends State<PraticienPage> {
  final List<int> durationInMinutesList = [15, 30, 45, 60];
  int? _selectedDuration;

  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    _selectedDuration ??= durationInMinutesList.first;
    final List<TimeOfDay> hours = _getHours(8, 18, _selectedDuration!);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Prendre rendez-vous'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _getPraticienCard(),
            Card(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              elevation: 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyDatePicker(onDateSelected: (DateTime date) {
                    setState(() {
                      _selectedDate = date;
                    });
                  }),
                  const SizedBox(width: 20),
                  _getDurationDropdown(
                      _selectedDuration, durationInMinutesList),
                ],
              ),
            ),
            Flexible(
              child: Card(
                margin: const EdgeInsets.all(20),
                elevation: 5,
                child: Column(
                  children: [
                    const ListTile(
                      leading: Icon(Icons.timer),
                      title: Text('Sélectionnez une plage horaire'),
                    ),
                    Expanded(
                      child: _getListedHours(hours, context),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListView _getListedHours(List<TimeOfDay> hours, BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: hours
          .map((TimeOfDay hour) => Container(
                margin: const EdgeInsets.all(5),
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AppointmentForm(
                            rdv: Rdv(
                                date: DateTime(
                                  _selectedDate.year,
                                  _selectedDate.month,
                                  _selectedDate.day,
                                  hour.hour,
                                  hour.minute,
                                ),
                                durationInMinutes: _selectedDuration!)),
                      ),
                    );
                  },
                  child: Text(hour.format(context),
                      style: const TextStyle(fontSize: 16)),
                ),
              ))
          .toList(),
    );
  }

  List<TimeOfDay> _getHours(int startHour, int endHour, int duration) {
    final List<TimeOfDay> hours = [];
    const int minutesInHour = 60;
    int currentMinute = 0;

    for (int i = startHour; i < endHour; i++) {
      while (currentMinute < minutesInHour) {
        hours.add(TimeOfDay(hour: i, minute: currentMinute));
        currentMinute += duration;
      }
      currentMinute -= minutesInHour;
    }
    return hours;
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
          this._selectedDuration = value!;
        });
      },
      hint: const Text('Durée'),
    );
  }

  Card _getPraticienCard() {
    return Card(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      elevation: 5,
      child: ListTile(
        leading: const Icon(Icons.person),
        title: Text('Dr. ${widget.praticien.nom} ${widget.praticien.prenom}'),
        subtitle: Text(widget.praticien.specialite),
      ),
    );
  }
}
