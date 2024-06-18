import 'package:flutter/material.dart';
import 'package:project/Devon/providers.dart';
import 'package:provider/provider.dart';

class PengajuanSuratAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final bool sendIcon;
  final BuildContext contextPage;
  final List userData;
  const PengajuanSuratAppBarWidget(
      {super.key,
      required this.sendIcon,
      required this.contextPage,
      required this.userData});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      backgroundColor: Colors.grey[350],
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(this.contextPage);
        },
      ),
      actions: [
        this.sendIcon
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: RotatedBox(
                  quarterTurns: 3,
                  child: TextButton(
                    onPressed: () {
                      Provider.of<userDataProvider>(context, listen: false)
                          .addUser(
                        {
                          "name": "Ayu ",
                          "Subject": "Surat Pengajuan Pembelian Unit",
                          "tgl": "Apr 25",
                          "status": "Urgent",
                          "progres": "Pending"
                        },
                      );
                      Navigator.pop(this.contextPage);
                    },
                    child: Icon(IconData(0xe571,
                        fontFamily: 'MaterialIcons', matchTextDirection: true)),
                  ),
                ),
              )
            : Text("")
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
