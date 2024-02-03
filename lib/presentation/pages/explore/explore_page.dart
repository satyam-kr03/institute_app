import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _logoController = TextEditingController();

  final List<String> _items = [];

  Future<void> fetchData() async {
    final QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection('organizations').get();

    final dataList = querySnapshot.docs.map((doc) {
      return doc.data()! as Map<String, dynamic>;
    }).toList();

    for (final item in dataList) {
      _items.add(item['name'] as String);
    }
  }

  final List<String> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    fetchData();
    _filteredItems.addAll(_items);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterSearchResults(String query) {
    final searchResults = <String>[];
    searchResults.addAll(_items);

    if (query.isNotEmpty) {
      searchResults.retainWhere(
              (item) => item.toLowerCase().contains(query.toLowerCase()));
    }

    setState(() {
      _filteredItems
        ..clear()
        ..addAll(searchResults);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                  context: context, delegate: SearchItems(items: _items));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('organizations')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot ds = snapshot.data!.docs[index];
                    return LogoListTile(
                      title: ds['name'] as String,
                      subtitle: ds['short_description'] as String,
                      logoUrl: ds['logoUrl'] as String,
                      description: ds['description'] as String,
                      websiteUrl: ds['website_url'] as String,
                      parentReference:
                      ds['parent_organization'] as DocumentReference,
                    );
                  },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addItem() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Organization'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Enter the name of the organization to add.'),
              const SizedBox(height: 16),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: 'Enter organization name',
                ),
              ),
              TextField(
                controller: _descController,
                decoration: const InputDecoration(
                  hintText: 'Enter short description',
                ),
              ),
              TextField(
                controller: _logoController,
                decoration: const InputDecoration(
                  hintText: 'Enter logo url',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Add the new item to the list
                final dataToSave = <String, String>{
                  'name': _nameController.text,
                  'short_description': _descController.text,
                  'logoUrl': _logoController.text,
                };

                FirebaseFirestore.instance
                    .collection('organizations')
                    .add(dataToSave);
                setState(() {
                  _items.add(_nameController.text);
                  _filteredItems.add(_nameController.text);
                });
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}

class SearchItems extends SearchDelegate<String> {
  SearchItems({required this.items});
  final List<String> items;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final searchResults = query.isEmpty
        ? List.from(items)
        : items
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(searchResults[index] as String),
          onTap: () {
            close(context, searchResults[index] as String);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<String> suggestionList = query.isEmpty
        ? List.from(items)
        : items
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestionList[index]),
          onTap: () {
            query = suggestionList[index];
            showResults(context);
          },
        );
      },
    );
  }
}

class LogoListTile extends StatelessWidget {
  const LogoListTile({
    required this.title,
    required this.subtitle,
    required this.logoUrl,
    required this.websiteUrl,
    required this.description, required this.parentReference, super.key,
  });
  final String title;
  final String subtitle;
  final String logoUrl;
  final String description;
  final String websiteUrl;
  final DocumentReference parentReference;



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrganizationPage(
                name: title,
                shortDescription: subtitle,
                logoUrl: logoUrl,
                description: description,
                websiteUrl: websiteUrl,
                parentReference: parentReference,
              ),
            ),
          );
        },
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(logoUrl),
            backgroundColor: Colors.white,
            radius: 20.0,
          ),
          title: Text(title),
          subtitle: Text(subtitle),
        ),
      ),
    );
  }
}

class OrganizationPage extends StatelessWidget {
  OrganizationPage({
    required this.name,
    required this.shortDescription,
    required this.logoUrl,
    required this.description,
    required this.websiteUrl,
    required this.parentReference,
    super.key,
  });

  final String name;
  final String shortDescription;
  final String logoUrl;
  final String description;
  final String websiteUrl;
  final DocumentReference parentReference;

  String parentName = '';

  Future<void> getParent() async {
    final snapshot = await parentReference.get();
    if(snapshot.exists) {
      final data = snapshot.data()! as Map<String, dynamic>;
      parentName = data['name'] as String;
      print('Parent: $parentName');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: FutureBuilder(
          future: getParent(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(shortDescription),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Align(
                      alignment: FractionalOffset.topCenter,
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Image.network(logoUrl),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(description),
                        const SizedBox(height: 16),
                        InkWell(
                          onTap: () => {launchUrlString(websiteUrl)},
                          child: const Text(
                            'Go to website',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text('Part of : $parentName'),
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
