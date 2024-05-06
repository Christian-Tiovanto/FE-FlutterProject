import 'package:flutter/material.dart';
import 'package:project/user.dart';
import 'package:project/homeandhistory/history_page.dart';
import 'package:project/homeandhistory/home_page.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserPage(),
    );
  }
}
