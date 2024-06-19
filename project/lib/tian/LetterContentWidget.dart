import 'package:flutter/material.dart';
import 'package:project/Devon/providers.dart';
import 'package:project/tian/PengajuanSuratWidget/dropDownMenuWidget.dart';
import 'package:project/tian/PengajuanSuratWidget/pengajuanAppBarWidget.dart';
import 'package:project/tian/PengajuanSuratWidget/textFieldWidget.dart';
import 'package:provider/provider.dart';

class LetterContentWidget extends StatelessWidget {
  final Mail dataSurat;
  const LetterContentWidget({super.key, required this.dataSurat});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: PengajuanSuratAppBarWidget(
          Subject: [],
          sendIcon: false,
          contextPage: context,
          selectedUser: [],
        ),
        body: ListView(
          children: [
            Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                      radius: 24,
                      child: Text(
                        this.dataSurat.name[0].toUpperCase(),
                        style: TextStyle(fontSize: 20),
                      )),
                  title: Row(
                    children: [
                      Text(
                        this.dataSurat.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        this.dataSurat.tgl,
                      )
                    ],
                  ),
                  subtitle: Text('Kepada Saya'),
                  trailing: SizedBox(
                    width: 60,
                    child: Text(
                      textAlign: TextAlign.center,
                      "General Manager",
                      maxLines: 100,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    this.dataSurat.Subject,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut gravida tellus et lacus venenatis molestie. Fusce sit amet volutpat nisi, eget elementum felis. Phasellus ligula metus, facilisis quis est sed, molestie tempus felis. Maecenas nec felis ex. Nulla id semper metus. Aliquam urna mauris, viverra sit amet volutpat ultrices, iaculis at est. Quisque id accumsan mauris.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut gravida tellus et lacus venenatis molestie. Fusce sit amet volutpat nisi, eget elementum felis. Phasellus ligula metus, facilisis quis est sed, molestie tempus felis. Maecenas nec felis ex. Nulla id semper metus. Aliquam urna mauris, viverra sit amet volutpat ultrices, iaculis at est. Quisque id accumsan mauris.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut gravida tellus et lacus venenatis molestie. Fusce sit amet volutpat nisi, eget elementum felis. Phasellus ligula metus, facilisis quis est sed, molestie tempus felis. Maecenas nec felis ex. Nulla id semper metus. Aliquam urna mauris, viverra sit amet volutpat ultrices, iaculis at est. Quisque id accumsan mauris.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut gravida tellus et lacus venenatis molestie. Fusce sit amet volutpat nisi, eget elementum felis. Phasellus ligula metus, facilisis quis est sed, molestie tempus felis. Maecenas nec felis ex. Nulla id semper metus. Aliquam urna mauris, viverra sit amet volutpat ultrices, iaculis at est. Quisque id accumsan mauris."),
                ),
                ResponsePopUpFormWidget(
                  dataSurat: dataSurat,
                  LetterContentWidgetContext: context,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ResponsePopUpFormWidget extends StatelessWidget {
  final Mail dataSurat;
  final BuildContext LetterContentWidgetContext;
  const ResponsePopUpFormWidget(
      {super.key,
      required this.dataSurat,
      required this.LetterContentWidgetContext});

  @override
  Widget build(BuildContext context) {
    final MailFinished = Provider.of<UserListProvider>(context);
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
                Text("RESPON"),
                DropdownMenuExample(
                  listData: ["1", "2"],
                ),
                SizedBox(height: 20),
                Text("TANGGAPAN"),
                SizedBox(height: 20),
                Container(
                  color: Colors.grey.shade100,
                  width: double.infinity,
                  child: TextFieldExample(
                    isBorder: false,
                    title: "",
                    subjectValue: [],
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
              onPressed: () {
                dataSurat.progres = 'Finished';
                MailFinished.addMail();
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
              Size.fromWidth(MediaQuery.of(context).size.width - 10))),
    );
  }
}
