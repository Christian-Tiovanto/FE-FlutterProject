import 'package:flutter/material.dart';
import 'dart:async';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => LoginPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = Offset(1.0, 0.0);
            var end = Offset.zero;
            var curve = Curves.ease;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Tampilan WelcomePage
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome Page'),
      ),
      body: Center(
        child: Image.asset('../../images/KM Logo 2.png', width: 300),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset('../../images/KM Logo 2.png', width: 300),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 90, vertical: 3),
              child: TextField(
                decoration: InputDecoration(
                  suffixStyle: TextStyle(color: Colors.red),
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(27.10),
                  ),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[800]),
                  prefixIcon: Icon(Icons.account_circle),
                  hintText: "User ID",
                  fillColor: Colors.grey[200],
                ),
              )),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 90, vertical: 6),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(27.10),
                  ),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[800]),
                  prefixIcon: Icon(Icons.lock),
                  hintText: "Password",
                  fillColor: Colors.grey[200],
                ),
              )),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 90, vertical: 25),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color.fromARGB(255, 0, 201, 7),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27.10)),
                  minimumSize: Size(2000, 50),
                ),
                onPressed: () {},
                child: Text('Login'),
              )),
        ],
      ),
    );
  }
}
