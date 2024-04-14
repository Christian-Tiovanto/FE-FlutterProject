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
      ),
      debugShowCheckedModeBanner: false,
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
