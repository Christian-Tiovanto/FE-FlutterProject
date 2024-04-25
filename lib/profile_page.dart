import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Container(color: Colors.red),
    Container(color: Colors.blue),
    ProfilePageWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: _navBarItems,
      ),
    );
  }
}

class ProfilePageWidget extends StatelessWidget {
  const ProfilePageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Tambahkan fungsi logout di sini
            },
          ),
        ],
      ),
      body: ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          SizedBox(height: 10),
          Center(
            child: Text(
              'Role : Direktur',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ),
          SizedBox(height: 10),
          Divider( // Tambahkan Divider di sini
            color: Colors.grey,
            thickness: 1,
          ),
          SizedBox(height: 10),
          Text(
            'Email :',
            style: TextStyle(fontSize: 22, color: Colors.black),
          ),
          Text(
            'christiantiovano@com',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          SizedBox(height: 10),
          Divider( // Tambahkan Divider di sini
            color: Colors.grey,
            thickness: 1,
          ),
          SizedBox(height: 10),
          Text(
            'Nomor HP :',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          Text(
            '012345678910',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
        ],
      ),
    );
  }
}

final _navBarItems = [
  SalomonBottomBarItem(
    icon: const Icon(Icons.mail),
    title: const Text("Mail"),
    selectedColor: Colors.red, // Ubah warna sesuai preferensi Anda
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.history),
    title: const Text("History"),
    selectedColor: Colors.blue, // Ubah warna sesuai preferensi Anda
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.person),
    title: const Text("Profile"),
    selectedColor: Colors.teal, // Ubah warna sesuai preferensi Anda
  ),
];