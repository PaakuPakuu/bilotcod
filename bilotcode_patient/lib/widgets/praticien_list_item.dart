import 'package:flutter/material.dart';

import '../models/praticien.dart';

class PraticienListItem extends ListTile {
  PraticienListItem({
    super.key,
    required Praticien praticien,
    required Function onTap,
  }) : super(
          leading: const Icon(Icons.person),
          title: Text(praticien.nom),
          subtitle: Text(praticien.specialite),
          onTap: () => onTap(praticien),
          trailing: const Icon(Icons.arrow_forward_ios),
        );
}
