import 'package:bilotcode_praticien/app_state.dart';
import 'package:bilotcode_praticien/models/rdv.dart';
import 'package:bilotcode_praticien/widgets/praticien_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  ListPageState createState() => ListPageState();
}

class ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: _getRdvs(),
    );
  }

  List<PraticienListItem> _getRdvs() {
    final List<Rdv> rdvs = context.watch<ApplicationState>().rdvs;
    return List.generate(rdvs.length, (int index) {
      return PraticienListItem(rdv: rdvs[index]);
    });
  }
}
