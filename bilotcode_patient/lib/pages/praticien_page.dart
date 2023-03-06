import 'package:bilotcod_patient/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            _getSelectDateCard(),
            Flexible(
              child: _getSelectHourCard(context, hours),
            ),
          ],
        ),
      ),
    );
  }

  Card _getSelectHourCard(BuildContext context, List<TimeOfDay> hours) {
    return Card(
      margin: const EdgeInsets.all(20),
      elevation: 5,
      child: Column(
        children: [
          const ListTile(
            leading: Icon(Icons.timer),
            title: Text('Sélectionnez une plage horaire'),
          ),
          Expanded(
            child: !context.watch<ApplicationState>().areRdvsLoading
                ? _getListedHours(hours, context)
                : const Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
    );
  }

  Card _getSelectDateCard() {
    return Card(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      elevation: 5,
      child: Column(
        children: [
          const ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text('Sélectionnez une date et une durée'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyDatePicker(onDateSelected: (DateTime date) {
                _selectedDate = date;
              }),
              const SizedBox(width: 20),
              _getDurationDropdown(_selectedDuration, durationInMinutesList),
            ],
          ),
        ],
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
                                widget.praticien,
                                DateTime(
                                    _selectedDate.year,
                                    _selectedDate.month,
                                    _selectedDate.day,
                                    hour.hour,
                                    hour.minute),
                                _selectedDuration!,
                                false)),
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
          _selectedDuration = value!;
        });
      },
      hint: const Text('Durée'),
    );
  }

  Card _getPraticienCard() {
    return Card(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      elevation: 2,
      child: ListTile(
        leading: const Icon(Icons.person),
        title: Text('Dr. ${widget.praticien.nom} ${widget.praticien.prenom}'),
        subtitle: Text(widget.praticien.specialite),
      ),
    );
  }
}
