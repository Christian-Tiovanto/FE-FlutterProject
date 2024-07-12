// ignore: file_names
import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:project/Devon/providers.dart';
import 'package:project/tian/PengajuanSuratWidget/containerKolomPengajuanWidget.dart';
import 'package:project/tian/PengajuanSuratWidget/dropDownMenuWidget.dart';
import 'package:project/tian/PengajuanSuratWidget/pengajuanAppBarWidget.dart';
import 'package:project/tian/PengajuanSuratWidget/searchUserWidget.dart';
import 'package:project/tian/PengajuanSuratWidget/textFieldWidget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class PengajuanSurat extends StatefulWidget {
  const PengajuanSurat({super.key});

  @override
  State<PengajuanSurat> createState() => _PengajuanSuratState();
}

class _PengajuanSuratState extends State<PengajuanSurat> {
  final bool _visible = false;
  final List<User> SelectedUser = [];
  final String IsiSurat = '';
  bool userFetched = false;
  Map<String, dynamic> userData = {};
  late SharedPreferences prefs;
  initPrefsAndGetUserData() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      if (!prefs.containsKey('token')) {
        throw Exception("You have to logged in first");
      }
      String token = prefs.getString('token')!;
      setState(() {
        userData = JwtDecoder.decode(token);
        userFetched = true;
      });
    } catch (e) {
      print('error di pengajuan');
      print(e);
    }
  }

  @override
  initState() {
    super.initState();
    initPrefsAndGetUserData();
  }

  @override
  Widget build(BuildContext context) {
    final PrioritasSuratValue = Provider.of<MailValue>(context).mailPriority;

    List subjectValue = Provider.of<MailValue>(context).subjectValue;
    List descriptionValue = Provider.of<MailValue>(context).descriptionValue;
    final prov = Provider.of<Settings_provider>(context);
    // return Scaffold(
    //   body: Text("ea"),
    // );

    return !userFetched
        ? const CircularProgressIndicator()
        : Scaffold(
            appBar: PengajuanSuratAppBarWidget(
                contextPage: context,
                sendIcon: true,
                Subject: subjectValue,
                selectedUser: SelectedUser,
                description: descriptionValue,
                prioritas: PrioritasSuratValue),
            body: Column(
              children: [
                ListView(
                  shrinkWrap: true,
                  children: [
                    ContainerKolomPengajuanSuratWidget(
                      firstPart: Text(
                        "Dari : ",
                        style: TextStyle(
                          color: prov.enableDarkMode == true
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      secondPart: Text(userData['name'],
                          style: TextStyle(
                            height: 1,
                            fontSize: 15,
                            color: prov.enableDarkMode == true
                                ? Colors.white
                                : Colors.black,
                          )),
                      containerPadding: PaddingLeftAndRight(
                          leftPadding: 20, rightPadding: 20),
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: SearchUserWidget(
                          Subject: subjectValue,
                          description: descriptionValue,
                          IsiSurat: IsiSurat,
                          selectedUsers: SelectedUser,
                        )),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}
