import 'package:bilotcode_praticien/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/rdv.dart';

class PraticienListItem extends ListTile {
  final Rdv rdv;

  const PraticienListItem({required this.rdv, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.person),
      title:
          Text('${rdv.patient.nom} ${rdv.patient.prenom}, ${rdv.patient.age}'),
      subtitle: Text(rdv.datetime.toString()),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () => print('Tapped on ${rdv.patient.nom} ${rdv.patient.prenom}'),
      onLongPress: () => context.read<ApplicationState>().removeRdv(rdv),
    );
  }
}
