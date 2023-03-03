import 'package:bilotcode_praticien/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

import '../models/rdv.dart';

class PraticienListItem extends ListTile {
  final Rdv rdv;

  const PraticienListItem({required this.rdv, super.key});

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('EEEE d MMMM yyyy, à HH:mm', 'fr_FR');
    final dateString = formatter.format(rdv.datetime);

    return ListTile(
      leading: const Icon(Icons.person),
      title: Text(
          '${rdv.patient.nom} ${rdv.patient.prenom}, ${rdv.patient.age} ans'),
      subtitle: Text("$dateString. Pendant ${rdv.dureeMinutes} minutes"),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () => print('Tapped on ${rdv.patient.nom} ${rdv.patient.prenom}'),
      onLongPress: () async =>
          await context.read<ApplicationState>().removeRdv(rdv),
    );
  }
}
