import 'package:flutter/material.dart';

class CreateUserPage extends StatefulWidget {
  @override
  _CreateUserPageState createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create User'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 100, right: 100, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 300,
                height: 300, // Adjust container height as needed
                child: Image(image: AssetImage('assets/logo.png')),
              ),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: true, // Hide password input
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _confirmPasswordController,
                obscureText: true, // Hide password confirmation
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final username = _usernameController.text.trim();

                  if (username.isEmpty) {
                    // Show dialog for empty username
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Error'),
                        content: Text('Username is required.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    );
                    return;
                  }

                  // Simulate user creation and password storage (replace with actual logic)
                  print('User created: $username, Password: (hidden)');

                  // Pop the navigation and send the created username back
                  Navigator.pop(context, username);
                },
                child: Text('Create User'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
