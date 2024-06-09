import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Updating_page extends StatelessWidget {
  const Updating_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 150,
            ),
            Center(child: Image.asset('assets/upgrade.jpg', width: 400)),
            Text(
              "Updates In Progress",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'We are updating the system to give you a better experience.',
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
                Text('Please be patient, service will return in a few moments.',
                    style: TextStyle(fontSize: 13, color: Colors.grey))
              ],
            ),
            SizedBox(
              height: 180,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/logo.png', width: 40),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Kelapa Muda',
                  style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Papyrus',
                      fontSize: 15),
                ),
              ],
            )
          ]),
    );
  }
}
