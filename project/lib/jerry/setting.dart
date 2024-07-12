import 'package:flutter/material.dart';
import 'package:project/hadron/login_screen.dart';
import 'package:project/hadron/loginpage.dart';
import 'package:project/Devon/history_page.dart';
import 'package:project/Devon/home_page.dart';
import 'package:project/Devon/providers.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:provider/provider.dart';

class SettingWidget extends StatefulWidget {
  const SettingWidget({super.key});

  @override
  State<SettingWidget> createState() => _SettingWidgetState();
}

class _SettingWidgetState extends State<SettingWidget> {
  // int _selectedIndex = 2;
  @override
  Widget build(BuildContext context) {
    final userListProvider = Provider.of<UserListProvider>(context);

    final prov = Provider.of<Settings_provider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Dark Theme',
                      style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).textTheme.bodyLarge!.color),
                    ),
                    Switch(
                        value: prov.enableDarkMode,
                        activeColor: Colors.green,
                        onChanged: (val) {
                          prov.setBrightness = val;
                        })
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Logout',
                      style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).textTheme.bodyLarge?.color),
                    ),
                    IconButton(
                      icon: const Icon(Icons.logout),
                      onPressed: () {
                        userListProvider.removeOnlineUser();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login_screen()),
                          (route) =>
                              false, // fungsi ini mengembalikan false untuk menghapus semua route lainnya dari stack
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
