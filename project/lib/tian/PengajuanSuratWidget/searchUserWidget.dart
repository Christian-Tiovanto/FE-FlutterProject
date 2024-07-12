import 'package:flutter/material.dart';
import 'package:project/Devon/providers.dart';
import 'package:project/services/user_services.dart';
import 'package:project/tian/PengajuanSuratWidget/containerKolomPengajuanWidget.dart';
import 'package:project/tian/PengajuanSuratWidget/dropDownMenuWidget.dart';
import 'package:project/tian/PengajuanSuratWidget/textFieldWidget.dart';
import 'package:provider/provider.dart';

class SearchUserWidget extends StatefulWidget {
  SearchUserWidget(
      {super.key,
      required this.selectedUsers,
      required this.Subject,
      required this.IsiSurat,
      required this.description});
  final List<User> selectedUsers;
  List Subject;
  List description;
  String IsiSurat;
  @override
  State<SearchUserWidget> createState() => _SearchUserWidgetState();
}

class _SearchUserWidgetState extends State<SearchUserWidget> {
  bool _visible = false;

  final snackBar = SnackBar(
    content: Text('Yay! A SnackBar!'),
  );

  List<User> _foundUsers = [];
  List<User> _allUsers = [];

  void getAllUsers() async {
    final results = await UserService().getAllUsers();
    print('results');
    print(results);
    setState(() {
      _allUsers = results;
    });
  }

  @override
  initState() {
    super.initState();
    getAllUsers();
  }

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

    List<User> results = [];

    if (enteredKeyword.isEmpty) {
      results = _allUsers;
    } else {
      results = _allUsers.where((user) => callback(user.name)).toList();
      _foundUsers = results;
      print(_foundUsers);
    }
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<Settings_provider>(context);
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.only(left: 20),
              child: Align(
                child: Text(
                  "Kepada   ",
                  style: TextStyle(
                    color: prov.enableDarkMode == true
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                alignment: Alignment.topCenter,
              ),
            ),
            Expanded(
              child: Wrap(
                children: [
                  widget.selectedUsers.isEmpty
                      ? SizedBox(
                          width: 0,
                        )
                      : ListView.builder(
                          itemCount: widget.selectedUsers.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ListTile(
                              dense: true,
                              key: Key('selectedUsers${index}'),
                              visualDensity: VisualDensity(vertical: -4),
                              leading: CircleAvatar(
                                radius: 24,
                                child: Text(
                                  widget.selectedUsers[index].name[0]
                                      .toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: prov.enableDarkMode == true
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                              title:
                                  Text('${widget.selectedUsers[index].name}'),
                              trailing: TextButton(
                                onPressed: () {
                                  setState(() {
                                    widget.selectedUsers.removeAt(index);
                                  });
                                },
                                child: const Icon(IconData(0xef28,
                                    fontFamily: 'MaterialIcons')),
                              ),
                            );
                          }),
                  Container(
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
                ],
              ),
            ),
          ],
        ),
        Container(
          child: Visibility(
            replacement: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                ContainerKolomPengajuanSuratWidget(
                  firstPart: Text("Prioritas Surat",
                      style: TextStyle(
                        color: prov.enableDarkMode == true
                            ? Colors.white
                            : Colors.black,
                      )),
                  thirdPart: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 200, maxHeight: 500),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        isCollapsed: true,
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              50.0), // Set the radius as per your need
                        ),
                      ),
                      child: DropdownMenuExample(
                        value: "",
                        listData: ['Urgent', "Regular"],
                      ),
                    ),
                  ),
                  containerPadding:
                      PaddingLeftAndRight(leftPadding: 20, rightPadding: 20),
                ),
                TextFieldExample(
                  isBorder: true,
                  subjectValue: widget.Subject,
                  title: "Subject",
                ),
                TextFieldExample(
                  isBorder: false,
                  subjectValue: widget.description,
                  title: "Tulis Isi Surat",
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
                          // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          widget.selectedUsers.add(_foundUsers[index]);
                          setState(() {});
                        },
                        child: widget.selectedUsers.contains(_foundUsers[index])
                            ? Opacity(
                                opacity: 0.5,
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
                                  title: Text(
                                      '${_foundUsers[index].name.toLowerCase()}'),
                                  subtitle: Text('${_foundUsers[index].role}'),
                                ),
                              )
                            : ListTile(
                                key: Key('Found-User${index}'),
                                visualDensity: VisualDensity(vertical: -4),
                                leading: CircleAvatar(
                                  radius: 24,
                                  child: Text(
                                    _foundUsers[index].name[0].toUpperCase(),
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ),
                                title: Text(
                                    '${_foundUsers[index].name.toLowerCase()}'),
                                subtitle: Text('${_foundUsers[index].role}'),
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
