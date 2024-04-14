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
            ContainerKolomPengajuanSurat(),
          ],
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ContainerKolomPengajuanSurat extends StatelessWidget {
  const ContainerKolomPengajuanSurat({
    super.key,
  });

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
            "Dari",
            style: TextStyle(fontSize: 15, height: 1),
          ),
          title: Text('One-line with trailing widget',
              style: TextStyle(height: 1, fontSize: 15)),
          trailing: Icon(Icons.keyboard_arrow_down_outlined),
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
