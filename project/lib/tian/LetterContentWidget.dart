import 'package:flutter/material.dart';
import 'package:project/tian/PengajuanSuratWidget/pengajuanAppBarWidget.dart';

class LetterContentWidget extends StatelessWidget {
  const LetterContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: PengajuanSuratAppBarWidget(),
        body: ListView(
          children: [
            Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    radius: 24,
                    child: Text(
                      "User",
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                  title: Row(
                    children: [
                      Text(
                        'Hadron Herman Cong',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "12 Mei",
                      )
                    ],
                  ),
                  subtitle: Text('Kepada Saya'),
                  trailing: Text(
                    "General Manager",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  child: Text(
                    "Subject",
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
                FilledButton.tonal(
                  onPressed: () {},
                  child: const Text('Beri Respon'),
                  style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(Size.fromWidth(
                          MediaQuery.of(context).size.width - 10))),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
