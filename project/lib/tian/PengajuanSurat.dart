// ignore: file_names
import 'package:flutter/material.dart';
import 'package:project/tian/PengajuanSuratWidget/containerKolomPengajuanWidget.dart';
import 'package:project/tian/PengajuanSuratWidget/pengajuanAppBarWidget.dart';
import 'package:project/tian/PengajuanSuratWidget/searchUserWidget.dart';

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class PengajuanSurat extends StatefulWidget {
  const PengajuanSurat({super.key});

  @override
  State<PengajuanSurat> createState() => _PengajuanSuratState();
}

class _PengajuanSuratState extends State<PengajuanSurat> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: const PengajuanSuratAppBarWidget(),
        body: Expanded(
          child: ListView(
            shrinkWrap: true,
            children: const [
              ContainerKolomPengajuanSuratWidget(
                firstPart: Text("Jenis Surat"),
                secondPart: Text('One-linea with trailing widget',
                    style: TextStyle(height: 1, fontSize: 15)),
                thirdPart: Icon(Icons.keyboard_arrow_down_outlined),
              ),
              Expanded(
                child: ContainerKolomPengajuanSuratWidget(
                  firstPart: Expanded(child: SearchUserWidget()),
                ),
              ),
            ],
          ),
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

