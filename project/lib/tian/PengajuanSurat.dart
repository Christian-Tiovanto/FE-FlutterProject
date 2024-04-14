import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
        appBar: const _PengajuanSuratAppBarWidget(),
        body: Column(
          children: [
            ContainerKolomPengajuanSuratWidget(
              leadingText: "Dari",
              titleContent: Text('One-linea with trailing widget',
                  style: TextStyle(height: 1, fontSize: 15)),
              trailingContent: Icon(Icons.keyboard_arrow_down_outlined),
            ),
            ContainerKolomPengajuanSuratWidget(
              leadingText: "Kepada",
              titleContent: Text('One-linea with trailing widget',
                  style: TextStyle(height: 1, fontSize: 15)),
              trailingContent: Icon(Icons.keyboard_arrow_down_outlined),
            ),
            ContainerKolomPengajuanSuratWidget(
              leadingText: "Jenis Surat",
              titleContent: Text('One-linea with trailing widget',
                  style: TextStyle(height: 1, fontSize: 15)),
              trailingContent: Icon(Icons.keyboard_arrow_down_outlined),
            ),
          ],
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ContainerKolomPengajuanSuratWidget extends StatelessWidget {
  final String leadingText;
  final Widget? titleContent;
  final Icon? trailingContent;
  const ContainerKolomPengajuanSuratWidget(
      {super.key,
      this.leadingText = "text",
      this.titleContent,
      this.trailingContent});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      decoration:
          const BoxDecoration(border: Border(bottom: BorderSide(width: 1))),
      child: SizedBox(
        height: 40,
        child: ListTile(
          horizontalTitleGap: 30,
          titleAlignment: ListTileTitleAlignment.center,
          leading: Text(
            this.leadingText,
            style: TextStyle(fontSize: 15, height: 1),
          ),
          title: this.titleContent,
          trailing: this.trailingContent,
        ),
      ),
    );
  }
}

class _PengajuanSuratAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const _PengajuanSuratAppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.pink,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Icon(IconData(0xe0b3, fontFamily: 'MaterialIcons')),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: RotatedBox(
            quarterTurns: 3,
            child: Icon(IconData(0xe571,
                fontFamily: 'MaterialIcons', matchTextDirection: true)),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
