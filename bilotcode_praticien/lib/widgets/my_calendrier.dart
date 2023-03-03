import 'dart:math';

import 'package:bilotcode_praticien/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../models/rdv.dart';

class Calendrier extends StatefulWidget {
  const Calendrier({super.key});

  @override
  CalendrierState createState() => CalendrierState();
}

class CalendrierState extends State<Calendrier> {
  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      view: CalendarView.week,
      dataSource:
          _getCalendarDataSource(context.watch<ApplicationState>().rdvs),
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
        endTime: rdv.datetime.add(Duration(minutes: rdv.dureeMinutes)),
        subject: '${rdv.patient.nom} ${rdv.patient.prenom}',
        color: //random color
            Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0)
                .withOpacity(1.0),
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
