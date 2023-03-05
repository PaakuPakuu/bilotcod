import 'package:flutter/material.dart';

import 'liste_praticiens_page.dart';
import 'patient_rdvs_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    ListPraticiensPage(),
    PatientRdvsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _getBody(),
      ),
      bottomNavigationBar: _bottomNavBar(),
    );
  }

  IndexedStack _getBody() {
    return IndexedStack(
      index: _currentIndex,
      children: _pages,
    );
  }

  BottomNavigationBar _bottomNavBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'Praticiens',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.schedule),
          label: 'Vos RDVs',
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
}
