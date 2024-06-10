import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Error_page extends StatelessWidget {
  const Error_page({super.key});

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
            Center(child: Image.asset('assets/error.jpg', width: 400)),
            SizedBox(
              height: 0,
            ),
            Text(
              "Oops! An Error Occurred (400)",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Your request could not be processed. Please try again or',
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
                Text('check the information you entered',
                    style: TextStyle(fontSize: 13, color: Colors.grey))
              ],
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                // foregroundColor: Color(0xFFCACACA),
                backgroundColor: Colors.green[300],
                // elevation: 30,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27.10)),
                minimumSize: Size(100, 45),
                // shadowColor: Colors.black,
              ),
              onPressed: () {},
              child: Text(
                'Back',
                style: TextStyle(color: Colors.white),
              ),
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
