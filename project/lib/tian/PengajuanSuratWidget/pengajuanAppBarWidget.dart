import 'package:flutter/material.dart';
import 'package:project/Devon/providers.dart';
import 'package:provider/provider.dart';

class PengajuanSuratAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final bool sendIcon;
  final BuildContext contextPage;
  final List<User> selectedUser;
  final List Subject;
  const PengajuanSuratAppBarWidget(
      {super.key,
      required this.Subject,
      required this.sendIcon,
      required this.contextPage,
      required this.selectedUser});

  @override
  Widget build(BuildContext context) {
    final sender = Provider.of<UserListProvider>(context).users[0];
    final PrioritasSuratValue = Provider.of<MailValue>(context).PrioritasSurat;

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
                      for (var user in selectedUser) {
                        DateTime now = DateTime.now();
                        String formattedDate = "${now.day}-${now.month}";
                        print('Subject');
                        print(Subject);
                        print(PrioritasSuratValue);
                        user.MailInbox.add(Mail(
                            Subject: Subject[0],
                            name: sender!.name,
                            tgl: formattedDate,
                            status: PrioritasSuratValue[0],
                            progres: "Pending"));
                      }
                      Provider.of<UserListProvider>(context, listen: false)
                          .addMail();
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
