import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
          color: Colors.white), // Teks tubuh putih di latar belakang gelap
      bodyMedium: TextStyle(
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
  List descriptionValue = [''];
  List mailPriority = ['Urgent'];
  List responseSurat = ['rejected'];
}

class Mail {
  final String name;
  final String subject;
  final DateTime dateCreated;
  final String status;
  String progres;
  final String description;
  final String mailId;
  final double progresValue;
  factory Mail.fromJson(Map<String, dynamic> json) {
    return Mail(
        progresValue: json['progres'],
        subject: json['subject'],
        name: json['recipients'][0]['userId']['name'],
        dateCreated: DateTime.parse(json['dateCreated']).toLocal(),
        status: json['priority'],
        description: json['description'],
        progres: json['recipients'][0]['checked'],
        mailId: json['_id']);
  }

  Mail(
      {required this.subject,
      required this.progresValue,
      required this.mailId,
      required this.name,
      required this.dateCreated,
      required this.status,
      required this.progres,
      required this.description});
}

class MailSent {
  final String name;
  final String Subject;
  final DateTime tgl;
  final String status;
  final double progresValue;
  String progres;
  final String description;
  final String mailId;
  final String letterStatus;
  factory MailSent.fromJson(Map<String, dynamic> json) {
    return MailSent(
        progresValue: json['progres'],
        Subject: json['subject'],
        name: json['creator']['name'],
        tgl: DateTime.parse(json['dateCreated']),
        status: json['priority'],
        letterStatus: json['status'],
        description: json['description'],
        progres: json['recipients'][0]['checked'],
        mailId: json['_id']);
  }

  MailSent(
      {required this.progresValue,
      required this.Subject,
      required this.mailId,
      required this.name,
      required this.letterStatus,
      required this.tgl,
      required this.status,
      required this.progres,
      required this.description});
}

class User {
  final String name;
  final String nik;
  final String password;
  final String role;
  final String number;
  final List<Mail> MailInbox;
  final String userId;
  factory User.fromJson(Map<String, dynamic> json) {
    print(json);
    return User(
        userId: json['_id'],
        MailInbox: [],
        name: json['name'] ?? "none1",
        role: json['role'] ?? "none2",
        password: '',
        nik: json['nik'].toString() ?? "none3",
        number: json['phone_number'] ?? "");
  }
  User(
      {required this.name,
      required this.userId,
      required this.nik,
      required this.password,
      required this.role,
      required this.number,
      required this.MailInbox});
}

class UserListProvider extends ChangeNotifier {
  List<User> _users = [
    // User(
    //     name: "devon",
    //     nik: "12442",
    //     password: "devon",
    //     role: "Manager",
    //     number: "081375",
    //     MailInbox: [
    //       Mail(
    //           name: "andy",
    //           Subject: "Surat Pengunduran Diri",
    //           tgl: DateTime.now(),
    //           status: "Regular",
    //           progres: "Pending"),
    //       Mail(
    //           name: "Devon",
    //           Subject: "Surat Pengajuan Cuti",
    //           tgl: DateTime.now(),
    //           status: "Regular",
    //           progres: "Pending"),
    //       Mail(
    //           name: "Chris",
    //           Subject: "Surat Pengajuan Pembelian Unit",
    //           tgl: DateTime.now(),
    //           status: "Urgent",
    //           progres: "Finished"),
    //       Mail(
    //           name: "Jerry",
    //           Subject: "Surat Pengajuan Cuti",
    //           tgl: DateTime.now(),
    //           status: "Regular",
    //           progres: "Cancelled"),
    //       Mail(
    //           name: "Jerry W",
    //           Subject: "Surat Pengajuan Pembelian Unit",
    //           tgl: DateTime.now(),
    //           status: "Urgent",
    //           progres: "Pending"),
    //       Mail(
    //           name: "Hadron",
    //           Subject: "Surat Pengajuan Cuti",
    //           tgl: DateTime.now(),
    //           status: "Regular",
    //           progres: "Finished"),
    //       Mail(
    //           name: "Lina ",
    //           Subject: "Surat Pengajuan Pembelian Unit",
    //           tgl: DateTime.now(),
    //           status: "Urgent",
    //           progres: "Pending")
    //     ]),
    // User(
    //     name: "Christian",
    //     nik: "22111",
    //     password: "christian",
    //     role: "Manager",
    //     number: "081375",
    //     MailInbox: [
    //       Mail(
    //           name: "Jerry",
    //           Subject: "Surat Pengajuan Cuti",
    //           tgl: DateTime.now(),
    //           status: "Regular",
    //           progres: "Cancelled"),
    //       Mail(
    //           name: "Jerry W",
    //           Subject: "Surat Pengajuan Pembelian Unit",
    //           tgl: DateTime.now(),
    //           status: "Urgent",
    //           progres: "Pending"),
    //       Mail(
    //           name: "Hadron",
    //           Subject: "Surat Pengajuan Cuti",
    //           tgl: DateTime.now(),
    //           status: "Regular",
    //           progres: "Finished"),
    //       Mail(
    //           name: "Lina ",
    //           Subject: "Surat Pengajuan Pembelian Unit",
    //           tgl: DateTime.now(),
    //           status: "Urgent",
    //           progres: "Pending")
    //     ]),
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

  Future<void> getAllUsers(BuildContext context) async {
    const apiUrl =
        'http://192.168.1.146:3000/api/v1/users/list-all-users'; // Ganti dengan URL API Anda

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Jika permintaan berhasil, parse JSON response
        _users = jsonDecode(response.body)['data'];
        notifyListeners(); // Memberitahu listener bahwa data telah berubah
      } else {
        // Jika terjadi kesalahan pada permintaan HTTP
        throw Exception('Failed to load users');
      }
    } catch (e) {
      // Tangkap dan cetak kesalahan
      print('Error: $e');
      throw Exception('Server error');
    }
  }
}
