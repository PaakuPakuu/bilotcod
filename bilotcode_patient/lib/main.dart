import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  final List<String> items = List.generate(
      100, (index) => "Dr Jean Bonnot $index - Arnaqueur généraliste");
  List<String> filteredItems = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredItems = items;
    searchController.addListener(filterItems);
  }

  void filterItems() {
    List<String> tempList = [];
    if (searchController.text.isNotEmpty) {
      for (String item in items) {
        if (item.toLowerCase().contains(searchController.text.toLowerCase())) {
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
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void navigateToItemPage(String item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ItemPage(item: item),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Liste et champ de recherche',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Liste et champ de recherche'),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                decoration: const InputDecoration(
                  hintText: 'Rechercher...',
                ),
              ),
            ),
            Expanded(
              child: GridView.count(
                padding: const EdgeInsets.all(8),
                crossAxisCount: 1,
                childAspectRatio: 3,
                children: filteredItems.map((item) {
                  return GestureDetector(
                    onTap: () => navigateToItemPage(item),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text(item),
                            onTap: () => navigateToItemPage(item),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              '3 rue de l\'arbre 59000 Lille',
                              style: TextStyle(
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemPage extends StatelessWidget {
  final String item;

  const ItemPage({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item),
      ),
      body: Center(
        child: Text(
          item,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
