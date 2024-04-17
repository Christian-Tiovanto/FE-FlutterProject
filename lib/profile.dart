import 'package:flutter/material.dart';

class ProfilePageWidget extends StatelessWidget {
  const ProfilePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
      ),
      body: ProfilePage(),
    );
  }
}


class ProfilePage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: CircleAvatar(
              radius: 75,
            ),
          ),
          SizedBox(height: 25),
          Center(
            child: Text(
              'Nama : Christian Tiovano',
              style: TextStyle(fontSize: 22, color: Colors.black),
              
            ),
          ),
          SizedBox(height: 25),
          Center(
            child: Text(
              'Role : Direktur',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ),
          SizedBox(height: 25),
          Text(
            'Email',
            style: TextStyle(fontSize:22, color: Colors.black),
          ),
          SizedBox(height: 25),
          Text(
            'christiantiovano@com',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          SizedBox(height: 25),
          Text(
            'Nomor HP',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          SizedBox(height: 25),
          Text(
            '012345678910',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
        ],
      ),
    );
  }
}