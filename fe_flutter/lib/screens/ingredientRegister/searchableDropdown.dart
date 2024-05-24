import 'package:flutter/material.dart';

class SearchableListView extends StatefulWidget {
  final List<String> items;

  const SearchableListView({Key? key, required this.items}) : super(key: key);

  @override
  _SearchableListViewState createState() => _SearchableListViewState();
}

class _SearchableListViewState extends State<SearchableListView> {
  TextEditingController _searchController = TextEditingController();
  late List<String> _filteredItems;

  @override
  void initState() {
    _filteredItems = List.from(widget.items);
    super.initState();
  }

  void filterSearchResults(String query) {
    if (query.isNotEmpty) {
      List<String> filteredList = widget.items.where((item) {
        return item.toLowerCase().contains(query.toLowerCase());
      }).toList();
      setState(() {
        _filteredItems = filteredList;
      });
    } else {
      setState(() {
        _filteredItems = List.from(widget.items);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Search',
              hintText: 'Enter keyword',
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: filterSearchResults,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _filteredItems.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_filteredItems[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}

