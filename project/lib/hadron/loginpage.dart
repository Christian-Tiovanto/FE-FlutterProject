import 'package:flutter/material.dart';
// import 'package:project/Devon/maintenance_page.dart';
import 'package:project/jerry/user.dart';
import 'package:project/Devon/home_page.dart';
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
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome Page'),
      ),
      body: Center(
        child: Image.asset('assets/logo.png', width: 300),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();

  void _handleLogin() {
    String username = _usernameController.text;

    if (username == "admin") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => UserPage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 100.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage('assets/logo.png'),
              width: 300,
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 90, vertical: 3),
                child: TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    suffixStyle: TextStyle(color: Colors.red),
                    contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(27.10),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    prefixIcon: Icon(Icons.account_circle),
                    hintText: "Username",
                    fillColor: Colors.grey[200],
                  ),
                )),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 90, vertical: 6),
                child: TextField(
                  obscureText: true,
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
                  onPressed: _handleLogin,
                  child: Text('Login'),
                )),
          ],
        ),
      ),
    );
  }
}
