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

class MailValue extends ChangeNotifier {
  List subjectValue = [''];
  List PrioritasSurat = [''];
}

class Mail {
  final String name;
  final String Subject;
  final String tgl;
  final String status;
  final String progres;

  Mail(
      {required this.Subject,
      required this.name,
      required this.tgl,
      required this.status,
      required this.progres});
}

class User {
  final String name;
  final String nik;
  final String password;
  final String role;
  final String number;
  final List<Mail> MailInbox;
  User(
      {required this.name,
      required this.nik,
      required this.password,
      required this.role,
      required this.number,
      required this.MailInbox});
}

class UserListProvider extends ChangeNotifier {
  List<User> _users = [
    User(
        name: "devon",
        nik: "12442",
        password: "devon",
        role: "Manager",
        number: "081375",
        MailInbox: [
          Mail(
              name: "andy",
              Subject: "Surat Pengunduran Diri",
              tgl: "Apr 17",
              status: "Regular",
              progres: "Pending"),
          Mail(
              name: "Devon",
              Subject: "Surat Pengajuan Cuti",
              tgl: "Apr 18",
              status: "Regular",
              progres: "Pending"),
          Mail(
              name: "Chris",
              Subject: "Surat Pengajuan Pembelian Unit",
              tgl: "Apr 19",
              status: "Urgent",
              progres: "Finished"),
          Mail(
              name: "Jerry",
              Subject: "Surat Pengajuan Cuti",
              tgl: "Apr 18",
              status: "Regular",
              progres: "Cancelled"),
          Mail(
              name: "Jerry W",
              Subject: "Surat Pengajuan Pembelian Unit",
              tgl: "Apr 19",
              status: "Urgent",
              progres: "Pending"),
          Mail(
              name: "Hadron",
              Subject: "Surat Pengajuan Cuti",
              tgl: "Apr 18",
              status: "Regular",
              progres: "Finished"),
          Mail(
              name: "Lina ",
              Subject: "Surat Pengajuan Pembelian Unit",
              tgl: "Apr 19",
              status: "Urgent",
              progres: "Pending")
        ]),
    User(
        name: "Christian",
        nik: "22111",
        password: "christian",
        role: "Manager",
        number: "081375",
        MailInbox: [
          Mail(
              name: "Jerry",
              Subject: "Surat Pengajuan Cuti",
              tgl: "Apr 18",
              status: "Regular",
              progres: "Cancelled"),
          Mail(
              name: "Jerry W",
              Subject: "Surat Pengajuan Pembelian Unit",
              tgl: "Apr 19",
              status: "Urgent",
              progres: "Pending"),
          Mail(
              name: "Hadron",
              Subject: "Surat Pengajuan Cuti",
              tgl: "Apr 18",
              status: "Regular",
              progres: "Finished"),
          Mail(
              name: "Lina ",
              Subject: "Surat Pengajuan Pembelian Unit",
              tgl: "Apr 19",
              status: "Urgent",
              progres: "Pending")
        ]),
  ];

  User? _onlineusers;

  List<User> get users => _users;

  User? get onlineusers => _onlineusers;

  void addUser(User user) {
    _users.add(user);
    notifyListeners();
  }

  void removeUser(int index) {
    _users.removeAt(index);
    notifyListeners();
  }

  void addMail() {
    notifyListeners();
  }

  void updateUser(int index, User user) {
    _users[index] = user;
    notifyListeners();
  }

  void addOnlineUser(User onlineuser) {
    _onlineusers = onlineuser;
    notifyListeners();
  }

  void removeOnlineUser() {
    _onlineusers = null;
    notifyListeners();
  }
}
