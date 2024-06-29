import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Maintenance_page extends StatelessWidget {
  const Maintenance_page({super.key});

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
            Center(child: Image.asset('assets/Maintenance.jpg', width: 400)),
            SizedBox(
              height: 20,
            ),
            Text(
              "We are Under Maintenance...",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Our Application is currently undergoing ',
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
                Text(
                  'Scheduled Maintenance. We should be back shortly.',
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
                Text('Thank you for your patience.',
                    style: TextStyle(fontSize: 13, color: Colors.grey))
              ],
            ),
            SizedBox(
              height: 160,
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
