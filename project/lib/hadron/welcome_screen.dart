import 'package:flutter/material.dart';
// import 'package:scrappingwebsite/login_screen.dart';
// import 'package:scrappingwebsite/signup_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:project/Devon/providers.dart';
import 'dart:async';

import 'package:project/hadron/login_screen.dart';
import 'package:project/jerrywijaya/walkthrough.dart';
import 'package:provider/provider.dart';

class Welcome_screen extends StatefulWidget {
  const Welcome_screen({super.key});

  @override
  State<Welcome_screen> createState() => _Welcome_screenState();
}

class _Welcome_screenState extends State<Welcome_screen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WalkthroughSlider()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<Settings_provider>(context);
    return Scaffold(
      body: Column(
        children: [
          Container(
            // color: Colors.blue,
            decoration: BoxDecoration(
              color: Color(0xFFFF9900),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0),
                topRight: Radius.circular(0),
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(150),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFFFB03A), // Warna bayangan
                  spreadRadius: 15, // Jangkauan bayangan
                  // blurRadius: 10, // Jarak blur bayangan
                  // offset: Offset(4, 4), // Offset bayangan (x, y)
                ),
              ],
            ),
            width: double.infinity,
            height: 300.0,
            child: Center(child: Image(image: AssetImage('assets/logo.png'))),
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            'Welcome To',
            style: TextStyle(
              fontSize: 35, // Ukuran font
              // fontStyle: FontStyle.italic, // Gaya font (miring)
              fontWeight: FontWeight.bold, // Berat font (tebal)
              color: prov.enableDarkMode == true ? Colors.white : Colors.black,
            ),
          ),
          Text(
            "Kelapa Muda",
            style: TextStyle(
              fontSize: 35, // Ukuran font
              // fontStyle: FontStyle.italic, // Gaya font (miring)
              fontWeight: FontWeight.bold, // Berat font (tebal)
              color: prov.enableDarkMode == true ? Colors.white : Colors.black,
            ),
          ),
          SizedBox(
            height: 100,
          ),
          SpinKitFadingCube(
            size: 100,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
