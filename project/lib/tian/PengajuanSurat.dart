// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/tian/PengajuanSuratWidget/containerKolomPengajuanWidget.dart';
import 'package:project/tian/PengajuanSuratWidget/dropDownMenuWidget.dart';
import 'package:project/tian/PengajuanSuratWidget/pengajuanAppBarWidget.dart';
import 'package:project/tian/PengajuanSuratWidget/searchUserWidget.dart';
import 'package:project/tian/PengajuanSuratWidget/textFieldWidget.dart';

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class PengajuanSurat extends StatefulWidget {
  const PengajuanSurat({super.key});

  @override
  State<PengajuanSurat> createState() => _PengajuanSuratState();
}

class _PengajuanSuratState extends State<PengajuanSurat> {
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
    return MaterialApp(
      home: Scaffold(
        appBar: const PengajuanSuratAppBarWidget(),
        body: Column(
          children: [
            ListView(
              shrinkWrap: true,
              children: [
                ContainerKolomPengajuanSuratWidget(
                  firstPart: Text("Jenis Surat"),
                  secondPart: Text('One-linea with trailing widget',
                      style: TextStyle(height: 1, fontSize: 15)),
                  thirdPart: Icon(Icons.keyboard_arrow_down_outlined),
                  containerPadding:
                      PaddingLeftAndRight(leftPadding: 20, rightPadding: 20),
                ),
                Row(
                  children: [
                    SizedBox(width: 20),
                    Container(
                      child: Expanded(child: SearchUserWidget()),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

// class ContainerKolomPengajuanSuratWidget extends StatelessWidget {
//   final String? leadingText;
//   final Widget? titleContent;
//   final Widget? trailingContent;
//   const ContainerKolomPengajuanSuratWidget(
//       {super.key,
//       this.leadingText,
//       this.titleContent,
//       this.trailingContent});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.only(bottom: 10),
//       height: 40,
//       decoration:
//           const BoxDecoration(border: Border(bottom: BorderSide(width: 1))),
//       child: ListTile(
//         horizontalTitleGap: 30,
//         titleAlignment: ListTileTitleAlignment.center,
//         leading: Text(
//           this.leadingText,
//           style: TextStyle(fontSize: 15, height: 1),
//         ),
//         title: this.titleContent,
//         trailing: this.trailingContent,
//       ),
//     );
//   }
// }

