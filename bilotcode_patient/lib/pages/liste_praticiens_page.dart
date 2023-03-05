import 'package:bilotcod_patient/models/praticien.dart';
import 'package:flutter/material.dart';

import '../widgets/praticien_list_item.dart';
import 'praticien_page.dart';

class ListPraticiensPage extends StatefulWidget {
  const ListPraticiensPage({super.key});

  @override
  State<ListPraticiensPage> createState() => _ListPraticiensPageState();
}

class _ListPraticiensPageState extends State<ListPraticiensPage> {
  final List<Praticien> items = List.generate(
      10,
      (index) => Praticien('Nom $index', 'Prenom $index', 'Adresse $index',
          'Specialite $index'));
  List<Praticien> filteredItems = [];
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredItems = items;
    searchController.addListener(filterItems);
  }

  void filterItems() {
    List<Praticien> tempList = [];
    if (searchController.text.isNotEmpty) {
      for (Praticien item in items) {
        final toSearch = '${item.nom} ${item.prenom}';
        if (toSearch
            .toLowerCase()
            .contains(searchController.text.toLowerCase())) {
          tempList.add(item);
        }
      }
    } else {
      tempList = List.from(items);
    }
    setState(() {
      filteredItems = tempList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _getSearchBar(),
        ),
        Expanded(child: _getList()),
      ],
    );
  }

  ListView _getList() {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        return PraticienListItem(
          praticien: filteredItems[index],
          onTap: (Praticien praticien) => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PraticienPage(praticien: praticien),
              ),
            )
          },
        );
      },
    );
  }

  TextField _getSearchBar() {
    return TextField(
      controller: searchController,
      decoration: const InputDecoration(
        labelText: 'Search',
        hintText: 'Search',
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
