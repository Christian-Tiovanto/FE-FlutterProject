import 'package:flutter/material.dart';
import 'package:project/Devon/providers.dart';
import 'package:project/services/user_services.dart';
import 'package:provider/provider.dart';

class PengajuanSuratAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final bool sendIcon;
  final BuildContext contextPage;
  final List<User> selectedUser;
  final List Subject;
  final List description;
  final List prioritas;
  const PengajuanSuratAppBarWidget(
      {super.key,
      required this.prioritas,
      required this.description,
      required this.Subject,
      required this.sendIcon,
      required this.contextPage,
      required this.selectedUser});

  @override
  Widget build(BuildContext context) {
    // final sender = Provider.of<UserListProvider>(context).users[0];
    final PrioritasSuratValue = Provider.of<MailValue>(context).PrioritasSurat;
    final prov = Provider.of<Settings_provider>(context);

    return AppBar(
      automaticallyImplyLeading: true,
      backgroundColor: Colors.grey,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: prov.enableDarkMode == true ? Colors.white : Colors.black,
        ),
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
                    onPressed: () async {
                      final snackBar = SnackBar(
                        backgroundColor: Colors.red,
                        content: const Text('No Recipient Selected !'),
                      );
                      if (selectedUser.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        return;
                      }
                      List recipients = selectedUser.map((users) {
                        return {"userId": users.userId};
                      }).toList();
                      try {
                        await LetterService().postUserLetter(Subject[0],
                            description[0], prioritas[0], recipients);
                      } catch (error) {
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                      Navigator.pop(this.contextPage, "OK");
                    },
                    child: Icon(
                        color: prov.enableDarkMode == true
                            ? Colors.white
                            : Colors.black,
                        IconData(0xe571,
                            fontFamily: 'MaterialIcons',
                            matchTextDirection: true)),
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
