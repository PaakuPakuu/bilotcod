import 'package:bilotcode_praticien/app_state.dart';
import 'package:bilotcode_praticien/models/rdv.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/praticien.dart';
import 'calendar_page.dart';
import 'list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    ListPage(),
    CalendarPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final List<Rdv> rdvs =
        context.watch<ApplicationState>().selectedPraticienRdvs;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Bilotcod'),
          elevation: 0,
        ),
        body: !context.watch<ApplicationState>().arePraticiensLoading
            ? _getBody(context, rdvs)
            : const Center(
                child: CircularProgressIndicator(),
              ),
        bottomNavigationBar: _bottomNavBar());
  }

  Padding _getBody(BuildContext context, List<Rdv> rdvs) {
    final int todayRdvsCount = rdvs.where((Rdv rdv) => rdv.isToday).length;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Row(
            children: [
              const Text('Rendez-vous de'),
              Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: _praticiensDropdownList(context)),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: _refreshData,
              ),
            ],
          ),
          const Divider(),
          Text("$todayRdvsCount rendez-vous aujourd'hui"),
          if (context.watch<ApplicationState>().areRdvsLoading)
            const Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          else if (rdvs.isNotEmpty)
            Expanded(
              child: IndexedStack(
                index: _currentIndex,
                children: _pages,
              ),
            )
          else
            const Expanded(child: Center(child: Text('Aucun rendez-vous'))),
        ],
      ),
    );
  }

  DropdownButton<Praticien> _praticiensDropdownList(BuildContext context) {
    final List<Praticien> praticiens =
        context.watch<ApplicationState>().praticiens;
    final Praticien? selectedPraticien =
        context.watch<ApplicationState>().selectedPraticien;

    return DropdownButton<Praticien>(
        value: context.read<ApplicationState>().selectedPraticien,
        hint: const Text('Sélectionnez un praticien'),
        onChanged: (Praticien? value) {
          if (value != selectedPraticien) {
            setState(() {
              context.read<ApplicationState>().selectedPraticien = value!;
            });
          }
        },
        items: praticiens.map((Praticien praticien) {
          return DropdownMenuItem<Praticien>(
            value: praticien,
            child: Text(
                'Dr ${praticien.nom} ${praticien.prenom} - ${praticien.specialite}'),
          );
        }).toList());
  }

  BottomNavigationBar _bottomNavBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'Liste',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Calendrier',
        ),
      ],
      currentIndex: _currentIndex,
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }

  Future<void> _refreshData() async {
    await context.read<ApplicationState>().loadRdvs();
  }
}
