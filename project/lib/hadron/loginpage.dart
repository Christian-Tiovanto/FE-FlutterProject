import 'package:flutter/material.dart';
// import 'package:project/Devon/maintenance_page.dart';
import 'package:project/jerry/user.dart';
import 'package:project/Devon/home_page.dart';
import 'dart:async';
import 'package:project/jerrywijaya/walkthrough.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WalkthroughSlider()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/logo.png', width: 300),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
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
            const Image(
              image: AssetImage('assets/logo.png'),
              width: 300,
            ),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 90, vertical: 3),
                child: TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    suffixStyle: const TextStyle(color: Colors.red),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(27.10),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    prefixIcon: const Icon(Icons.account_circle),
                    hintText: "Username",
                    fillColor: Colors.grey[200],
                  ),
                )),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 90, vertical: 6),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(27.10),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    prefixIcon: const Icon(Icons.lock),
                    hintText: "Password",
                    fillColor: Colors.grey[200],
                  ),
                )),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 90, vertical: 25),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 0, 201, 7),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(27.10)),
                    minimumSize: const Size(2000, 50),
                  ),
                  onPressed: _handleLogin,
                  child: const Text('Login'),
                )),
          ],
        ),
      ),
    );
  }
}
