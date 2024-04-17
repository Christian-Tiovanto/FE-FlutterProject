//import 'dart:html';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Profile Page'),
        ),
        body: Center(
          child: ProfilePage(),
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row({
            mainAxisAlignment: MainAxisAlignment.center,
            Center(
              child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: (){}
          ),
            ),
          };
            children: [
              CircleAvatar(
                radius: 50,
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Nama : Christian Tiovano',
                style: TextStyle(fontSize: 22, color: Colors.black),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Role : Direktur',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Text(
                'Email',
                style: TextStyle(fontSize:22, color: Colors.black),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Text(
                'christiantiovano@com',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ],
          ),
          SizedBox(height: 18),
          Row(
            children: [
              Text(
                'Nomor HP',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Text(
                '012345678910',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
