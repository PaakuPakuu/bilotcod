import 'package:bilotcode_praticien/app_state.dart';
import 'package:bilotcode_praticien/models/rdv.dart';
import 'package:bilotcode_praticien/widgets/praticien_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: _getRdvs(),
    );
  }

  List<PraticienListItem> _getRdvs() {
    final List<Rdv> rdvs =
        context.watch<ApplicationState>().selectedPraticienRdvs;
    return List.generate(rdvs.length, (int index) {
      return PraticienListItem(rdv: rdvs[index]);
    });
  }
}
