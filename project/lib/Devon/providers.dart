import 'package:flutter/material.dart';

class Settings_provider extends ChangeNotifier {
  var light = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.purple,
  );

  var dark = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.purple,
    scaffoldBackgroundColor:
        Colors.grey[900], // Ubah latar belakang gelap di sini
    textTheme: TextTheme(
      bodyText1: TextStyle(
          color: Colors.white), // Teks tubuh putih di latar belakang gelap
      bodyText2: TextStyle(
          color: Colors.black), // Teks tubuh putih di latar belakang gelap
    ),
  );

  bool _enableDarkMode = false;
  bool get enableDarkMode => _enableDarkMode;

  set setBrightness(bool val) {
    _enableDarkMode = val;
    notifyListeners();
  }
}

class User {
  final String name;
  final String nik;
  final String password;
  final String role;
  final String number;

  User(
      {required this.name,
      required this.nik,
      required this.password,
      required this.role,
      required this.number});
}

class UserListProvider extends ChangeNotifier {
  List<User> _users = [
    User(
        name: "devon",
        nik: "12442",
        password: "devon",
        role: "Manager",
        number: "081375"),
  ];

  List<User> _onlineusers = [];

  List<User> get users => _users;

  List<User> get onlineusers => _onlineusers;

  void addUser(User user) {
    _users.add(user);
    notifyListeners();
  }

  void removeUser(int index) {
    _users.removeAt(index);
    notifyListeners();
  }

  void updateUser(int index, User user) {
    _users[index] = user;
    notifyListeners();
  }

  void addOnlineUser(User onlineuser) {
    _onlineusers.add(onlineuser);
    notifyListeners();
  }

  void removeOnlineUser() {
    _onlineusers.removeAt(0);
    notifyListeners();
  }
}
