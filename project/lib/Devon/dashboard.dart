import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:project/Devon/history_page.dart';
import 'package:project/Devon/home_page.dart';
import 'package:project/jerrywijaya/profile.dart';

class Dashboard_screen extends StatefulWidget {
  @override
  _Dashboard_screenState createState() => _Dashboard_screenState();
}

class _Dashboard_screenState extends State<Dashboard_screen> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    HomePage(),
    HistoryPage(),
    ProfilePageWidget(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Convex Bottom Bar Example'),
      // ),
      body: _children[_currentIndex],
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.reactCircle,
        color: Colors.white,
        backgroundColor: Colors.grey,
        items: [
          TabItem(icon: Icons.mail),
          TabItem(icon: Icons.history),
          TabItem(icon: Icons.person),
        ],
        initialActiveIndex: _currentIndex,
        onTap: onTabTapped,
      ),
    );
  }
}
