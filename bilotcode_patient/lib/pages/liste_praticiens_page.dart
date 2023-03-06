import 'package:bilotcod_patient/models/praticien.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_state.dart';
import '../widgets/praticien_list_item.dart';
import 'praticien_page.dart';

class ListPraticiensPage extends StatefulWidget {
  const ListPraticiensPage({super.key});

  @override
  State<ListPraticiensPage> createState() => _ListPraticiensPageState();
}

class _ListPraticiensPageState extends State<ListPraticiensPage> {
  final List<Praticien> _praticiens = [];
  List<Praticien> filteredItems = [];
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(filterItems);
  }

  void filterItems() {
    List<Praticien> tempList = [];
    if (searchController.text.isNotEmpty) {
      for (Praticien item in _praticiens) {
        final toSearch = '${item.nom} ${item.prenom}';
        if (toSearch
            .toLowerCase()
            .contains(searchController.text.toLowerCase())) {
          tempList.add(item);
        }
      }
    } else {
      tempList = List.from(_praticiens);
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
        Expanded(
            child: !context.watch<ApplicationState>().arePraticiensLoading
                ? _getList()
                : const Center(child: CircularProgressIndicator())),
      ],
    );
  }

  ListView _getList() {
    _praticiens.clear();
    _praticiens.addAll(context.watch<ApplicationState>().praticiens);
    filterItems();

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
