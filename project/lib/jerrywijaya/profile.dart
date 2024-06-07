import 'package:flutter/material.dart';
import 'package:project/Devon/history_page.dart';
import 'package:project/Devon/home_page.dart';
import 'package:project/jerrywijaya/setting.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class ProfilePageWidget extends StatefulWidget {
  const ProfilePageWidget({Key? key}) : super(key: key);

  @override
  State<ProfilePageWidget> createState() => _ProfilePageWidgetState();
}

class _ProfilePageWidgetState extends State<ProfilePageWidget> {
  int _selectedIndex = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingWidget()),
              );
            },
          ),
        ],
      ),
      body: ProfilePage(),
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

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 75,
                ),
              ),
              SizedBox(height: 25),
              Center(
                child: Text(
                  'Nama : Christian Tiovano',
                  style: TextStyle(fontSize: 22, color: Colors.black),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  'Role : Direktur',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
              SizedBox(height: 10),
              Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              SizedBox(height: 10),
              Text(
                'Email :',
                style: TextStyle(fontSize: 22, color: Colors.black),
              ),
              Text(
                'christiantiovano@com',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              SizedBox(height: 10),
              Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              SizedBox(height: 10),
              Text(
                'Nomor HP :',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              Text(
                '012345678910',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ],
          ),
        ),
        Spacer(),
      ],
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
