import 'dart:math';

import 'package:bilotcode_praticien/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../models/rdv.dart';

class Calendrier extends StatefulWidget {
  const Calendrier({super.key});

  @override
  State<Calendrier> createState() => _CalendrierState();
}

class _CalendrierState extends State<Calendrier> {
  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      minDate: DateTime.now().subtract(const Duration(days: 30)),
      maxDate: DateTime.now().add(const Duration(days: 365)),
      allowedViews: const <CalendarView>[
        CalendarView.week,
        CalendarView.day,
        CalendarView.month
      ],
      view: CalendarView.week,
      dataSource: _getCalendarDataSource(
          context.watch<ApplicationState>().selectedPraticienRdvs),
      monthViewSettings: const MonthViewSettings(
        appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
      ),
    );
  }

  _CalendarDataSource _getCalendarDataSource(List<Rdv> rdvs) {
    final List<Appointment> appointments = <Appointment>[];

    for (var rdv in rdvs) {
      appointments.add(Appointment(
        startTime: rdv.datetime,
        endTime: rdv.datetime.add(Duration(minutes: rdv.durationMinutes)),
        subject: '${rdv.patient.nom} ${rdv.patient.prenom}',
        color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
      ));
    }

    return _CalendarDataSource(appointments);
  }
}

class _CalendarDataSource extends CalendarDataSource {
  _CalendarDataSource(List<Appointment> source) {
    appointments = source;
  }
}
