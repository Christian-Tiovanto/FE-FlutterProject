import 'package:flutter/material.dart';
import 'package:project/hadron/loginpage.dart';
import 'package:project/Devon/history_page.dart';
import 'package:project/Devon/home_page.dart';
import 'package:project/Devon/switch_provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:provider/provider.dart';

class SettingWidget extends StatefulWidget {
  const SettingWidget({Key? key}) : super(key: key);

  @override
  State<SettingWidget> createState() => _SettingWidgetState();
}

class _SettingWidgetState extends State<SettingWidget> {
  int _selectedIndex = 2;
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<Pertemuan06Provider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
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
                Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Dark Theme',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    Switch(
                        value: prov.enableDarkMode,
                        activeColor: Colors.green,
                        onChanged: (val) {
                          prov.setBrightness = val;
                        })
                  ],
                ),
                SizedBox(height: 10),
                Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Logout',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    IconButton(
                      icon: Icon(Icons.logout),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
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
          Spacer(),
        ],
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xff6200ee),
        unselectedItemColor: const Color(0xff757575),
        onTap: (index) {
          if (index == 0) {
// mai page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } else if (index == 1) {
            //historypage
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HistoryPage()),
            );
          } else if (index == 2) {
// profile page
          }
        },
        items: [
          _navBarItems[0], // History
          _navBarItems[1], // Mail
          _navBarItems[2], // Profile
        ],
      ),
    );
  }
}

final _navBarItems = [
  SalomonBottomBarItem(
    icon: const Icon(Icons.mail),
    title: const Text("Mail"),
    selectedColor: Colors.red,
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.history),
    title: const Text("History"),
    selectedColor: Colors.blue,
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.person),
    title: const Text("Profile"),
    selectedColor: Colors.teal,
  ),
];
