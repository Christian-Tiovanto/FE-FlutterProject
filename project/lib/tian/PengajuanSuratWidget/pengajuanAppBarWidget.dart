import 'package:flutter/material.dart';

class PengajuanSuratAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const PengajuanSuratAppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.pink,
      actions: const [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6),
          child: Icon(IconData(0xe0b3, fontFamily: 'MaterialIcons')),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
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
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
