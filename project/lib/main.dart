// main.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _visible = false;
  final List<Map<String, dynamic>> _allUsers = [
    {"id": 1, "name": "Andy", "age": 29},
    {"id": 2, "name": "Aragon", "age": 40},
    {"id": 3, "name": "Bob", "age": 5},
    {"id": 4, "name": "Barbara", "age": 35},
    {"id": 5, "name": "Candy", "age": 21},
    {"id": 6, "name": "Colin", "age": 55},
    {"id": 7, "name": "Audra", "age": 30},
    {"id": 8, "name": "Banana", "age": 14},
    {"id": 9, "name": "Caversky", "age": 100},
    {"id": 10, "name": "Becky", "age": 32},
  ];

  // This list holds the data for the list view
  List<Map<String, dynamic>> _foundUsers = [];
  @override
  initState() {
    _foundUsers = _allUsers;
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    print(enteredKeyword);
    final regexp = r'^' + '${enteredKeyword}.*';
    RegExp exp = RegExp('${regexp}');
    bool callback(String text) {
      print('text');
      print(text);
      if (exp.firstMatch(text.toLowerCase()) is RegExpMatch) {
        return true;
      } else {
        return false;
      }
    }

    List<Map<String, dynamic>> results = [];
    print(enteredKeyword);
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers;
    } else {
      print("siniii");
      results = _allUsers.where((user) => callback(user["name"])).toList();
      _foundUsers = results;
      print(_foundUsers);
      // we use the toLowerCase() method to make it case-insensitive
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Listview'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.black)),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                onChanged: (value) => {
                  _runFilter(value),
                  setState(() {
                    if (value.isNotEmpty) {
                      _visible = true;
                    } else {
                      _visible = false;
                    }
                  })
                },
                // initialValue: ' ',
                decoration: InputDecoration(
                    icon: Text("Kepada   "), border: InputBorder.none),
              ),
              const SizedBox(
                height: 20,
              ),
              Visibility(
                replacement: Container(
                  height: 100,
                  color: Colors.black,
                ),
                visible: _visible,
                child: _foundUsers.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: _foundUsers.length,
                          itemBuilder: (context, index) => Card(
                            key: ValueKey(_foundUsers[index]["id"]),
                            color: Colors.blue,
                            elevation: 4,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: ListTile(
                              leading: Text(
                                _foundUsers[index]["id"].toString(),
                                style: const TextStyle(
                                    fontSize: 24, color: Colors.white),
                              ),
                              title: Text(_foundUsers[index]['name'],
                                  style: TextStyle(color: Colors.white)),
                              subtitle: Text(
                                  '${_foundUsers[index]["age"].toString()} years old',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ),
                      )
                    : const Text(
                        'No results found',
                        style: TextStyle(fontSize: 24),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
