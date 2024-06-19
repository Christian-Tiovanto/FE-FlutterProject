// ignore: file_names
import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/Devon/providers.dart';
import 'package:project/tian/PengajuanSuratWidget/containerKolomPengajuanWidget.dart';
import 'package:project/tian/PengajuanSuratWidget/dropDownMenuWidget.dart';
import 'package:project/tian/PengajuanSuratWidget/pengajuanAppBarWidget.dart';
import 'package:project/tian/PengajuanSuratWidget/searchUserWidget.dart';
import 'package:project/tian/PengajuanSuratWidget/textFieldWidget.dart';
import 'package:provider/provider.dart';

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class PengajuanSurat extends StatefulWidget {
  const PengajuanSurat({super.key});

  @override
  State<PengajuanSurat> createState() => _PengajuanSuratState();
}

class _PengajuanSuratState extends State<PengajuanSurat> {
  bool _visible = false;
  final List<User> SelectedUser = [];
  final String IsiSurat = '';
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final LoggedInUser = Provider.of<UserListProvider>(context).onlineusers;

    List subjectValue = Provider.of<MailValue>(context).subjectValue;
    final prov = Provider.of<Settings_provider>(context);
    return Scaffold(
      appBar: PengajuanSuratAppBarWidget(
        contextPage: context,
        sendIcon: true,
        Subject: subjectValue,
        selectedUser: SelectedUser,
      ),
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
                secondPart: Text(LoggedInUser!.name,
                    style: TextStyle(
                      height: 1,
                      fontSize: 15,
                      color: prov.enableDarkMode == true
                          ? Colors.white
                          : Colors.black,
                    )),
                containerPadding:
                    PaddingLeftAndRight(leftPadding: 20, rightPadding: 20),
              ),
              Row(
                children: [
                  Expanded(
                      child: SearchUserWidget(
                    Subject: subjectValue,
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
