import 'package:flutter/material.dart';
import 'package:project/tian/PengajuanSuratWidget/containerKolomPengajuanWidget.dart';
import 'package:project/tian/PengajuanSuratWidget/dropDownMenuWidget.dart';
import 'package:project/tian/PengajuanSuratWidget/textFieldWidget.dart';

class SearchUserWidget extends StatefulWidget {
  const SearchUserWidget({super.key});

  @override
  State<SearchUserWidget> createState() => _SearchUserWidgetState();
}

class _SearchUserWidgetState extends State<SearchUserWidget> {
  GlobalKey<FormState> _homeKey =
      GlobalKey<FormState>(debugLabel: '_homeScreenkey');
  bool _visible = false;

  List _selectedUsers = [];
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
    final regexp = r'^' '$enteredKeyword.*';
    RegExp exp = RegExp(regexp);
    bool callback(String text) {
      if (exp.firstMatch(text.toLowerCase()) is RegExpMatch) {
        return true;
      } else {
        return false;
      }
    }

    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers;
    } else {
      results = _allUsers.where((user) => callback(user["name"])).toList();
      _foundUsers = results;
      print(_foundUsers);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Row(
            children: [
              Container(
                height: 20,
                child: Align(
                  child: Text("Kepada   "),
                  alignment: Alignment.topCenter,
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    _selectedUsers.isEmpty
                        ? SizedBox(
                            width: 0,
                          )
                        : Expanded(
                            child: ListView.builder(
                                itemCount: _selectedUsers.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return TextButton(
                                    onPressed: () {},
                                    child: ListTile(
                                      dense: true,
                                      key: Key('selectedUsers${index}'),
                                      visualDensity:
                                          VisualDensity(vertical: -4),
                                      leading: CircleAvatar(
                                        radius: 24,
                                        child: Text(
                                          "User",
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      ),
                                      title: Text('User@gmail.com'),
                                    ),
                                  );
                                }),
                          ),
                    Expanded(
                      child: Container(
                        child: Container(
                          child: TextFormField(
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
                            decoration:
                                const InputDecoration(border: InputBorder.none),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          child: Visibility(
            replacement: Column(
              children: [
                ContainerKolomPengajuanSuratWidget(
                  firstPart: Text("Jenis Surat"),
                  thirdPart: DropdownMenuExample(
                    listData: ['1', '2', '3'],
                  ),
                  containerPadding:
                      PaddingLeftAndRight(leftPadding: 0, rightPadding: 0),
                ),
                SizedBox(
                  height: 10,
                ),
                ContainerKolomPengajuanSuratWidget(
                  firstPart: Text("Prioritas Surat"),
                  thirdPart: DropdownMenuExample(
                    listData: ['1', '2', '3'],
                  ),
                  containerPadding:
                      PaddingLeftAndRight(leftPadding: 0, rightPadding: 20),
                ),
                TextFieldExample(
                  isBorder: true,
                ),
                TextFieldExample(
                  isBorder: false,
                ),
              ],
            ),
            visible: _visible,
            child: _foundUsers.isNotEmpty
                ? ListView.builder(
                    itemCount: _foundUsers.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return TextButton(
                        onPressed: () {
                          _selectedUsers.add(_foundUsers[index]);
                          setState(() {});
                        },
                        child: ListTile(
                          key: Key('Found-User${index}'),
                          visualDensity: VisualDensity(vertical: -4),
                          leading: CircleAvatar(
                            radius: 24,
                            child: Text(
                              "User",
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                          title: Text('User@gmail.com'),
                          subtitle: Text('User@gmail.com'),
                        ),
                      );
                    })
                : const Text(
                    'No results found',
                    style: TextStyle(fontSize: 24),
                  ),
          ),
        ),
      ],
    );
  }
}
