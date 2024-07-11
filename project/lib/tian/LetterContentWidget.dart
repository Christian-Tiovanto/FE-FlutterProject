import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:project/Devon/providers.dart';
import 'package:project/services/user_services.dart';
import 'package:project/tian/PengajuanSuratWidget/dropDownMenuWidget.dart';
import 'package:project/tian/PengajuanSuratWidget/pengajuanAppBarWidget.dart';
import 'package:project/tian/PengajuanSuratWidget/textFieldWidget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LetterContentWidget extends StatefulWidget {
  final Mail dataSurat;
  const LetterContentWidget({super.key, required this.dataSurat});

  @override
  State<LetterContentWidget> createState() => _LetterContentWidgetState();
}

class _LetterContentWidgetState extends State<LetterContentWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<Settings_provider>(context);
    String responseValue = "";
    return Scaffold(
      appBar: PengajuanSuratAppBarWidget(
        Subject: [],
        sendIcon: false,
        contextPage: context,
        prioritas: [],
        selectedUser: [],
        description: [],
      ),
      body: ListView(
        children: [
          Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                    radius: 24,
                    child: Text(
                      this.widget.dataSurat.name[0].toUpperCase(),
                      style: TextStyle(
                        fontSize: 20,
                        color:
                            prov.enableDarkMode ? Colors.white : Colors.black,
                      ),
                    )),
                title: Row(
                  children: [
                    Text(
                      this.widget.dataSurat.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color:
                            prov.enableDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      DateFormat("yyyy-MM-dd")
                          .format(this.widget.dataSurat.tgl)
                          .toString(),
                      style: TextStyle(
                        color:
                            prov.enableDarkMode ? Colors.white : Colors.black,
                      ),
                    )
                  ],
                ),
                subtitle: Text(
                  'Kepada Saya',
                  style: TextStyle(
                    color: prov.enableDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                trailing: SizedBox(
                  width: 60,
                  child: Text(
                    "General Manager",
                    textAlign: TextAlign.center,
                    maxLines: 100,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: prov.enableDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
              Container(
                child: Text(
                  this.widget.dataSurat.Subject,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: prov.enableDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ),
              Divider(
                color: Colors.black,
                height: 50,
                thickness: 1,
              ),
              Container(
                child: Text(
                  "Pemberitahuan",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: prov.enableDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  widget.dataSurat.description,
                  style: TextStyle(
                    color: prov.enableDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ),
              ResponsePopUpFormWidget(
                dataSurat: widget.dataSurat,
                LetterContentWidgetContext: context,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ResponsePopUpFormWidget extends StatelessWidget {
  final Mail dataSurat;
  final BuildContext LetterContentWidgetContext;
  const ResponsePopUpFormWidget({
    super.key,
    required this.dataSurat,
    required this.LetterContentWidgetContext,
  });

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<Settings_provider>(context);
    final MailFinished = Provider.of<UserListProvider>(context);
    final ResponseSuratValue = Provider.of<MailValue>(context).responseSurat;
    return FilledButton.tonal(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Response'),
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "RESPON",
                  style: TextStyle(
                    color: prov.enableDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                DropdownMenuExample(
                  value: "",
                  listData: ["rejected", "approved"],
                ),
                SizedBox(height: 20),
                Text(
                  "TANGGAPAN",
                  style: TextStyle(
                    color: prov.enableDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  color: Colors.grey.shade100,
                  width: double.infinity,
                  child: TextFieldExample(
                    isBorder: false,
                    title: "",
                    subjectValue: [""],
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final snackBar = SnackBar(
                  backgroundColor: Colors.green,
                  content: const Text('Berhasil Memberikan respon !'),
                );
                final response = await LetterService()
                    .updateLetterRecipientStatus(
                        dataSurat.mailId, ResponseSuratValue[0]);
                print(response);
                if (response == true) {
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                Navigator.pop(context, 'OK');
                Navigator.pop(LetterContentWidgetContext, 'OK');
              },
              child: const Text('OK'),
            ),
          ],
        ),
      ),
      child: const Text('Beri Respon'),
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all(
          Size.fromWidth(MediaQuery.of(context).size.width - 10),
        ),
      ),
    );
  }
}
