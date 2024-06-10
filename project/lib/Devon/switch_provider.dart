import 'package:flutter/material.dart';

class Pertemuan06Provider extends ChangeNotifier {
  var light = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.purple,
  );

  var dark = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.purple,
  );

  bool _enableDarkMode = false;
  bool get enableDarkMode => _enableDarkMode;

  set setBrightness(val) {
    _enableDarkMode = val;
    notifyListeners();
  }
}

class userDataProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _allusers = [
    {
      "name": "andy",
      "Subject": "Surat Pengunduran Diri",
      "tgl": "Apr 17",
      "status": "Regular",
      "progres": "Pending"
    },
    {
      "name": "Devon",
      "Subject": "Surat Pengajuan Cuti",
      "tgl": "Apr 18",
      "status": "Regular",
      "progres": "Pending"
    },
    {
      "name": "Chris",
      "Subject": "Surat Pengajuan Pembelian Unit",
      "tgl": "Apr 19",
      "status": "Urgent",
      "progres": "Finished"
    },
    {
      "name": "Jerry",
      "Subject": "Surat Pengajuan Cuti",
      "tgl": "Apr 18",
      "status": "Regular",
      "progres": "Cancelled"
    },
    {
      "name": "Jerry W",
      "Subject": "Surat Pengajuan Pembelian Unit",
      "tgl": "Apr 19",
      "status": "Urgent",
      "progres": "Pending"
    },
    {
      "name": "Hadron",
      "Subject": "Surat Pengajuan Cuti",
      "tgl": "Apr 18",
      "status": "Regular",
      "progres": "Finished"
    },
    {
      "name": "Lina ",
      "Subject": "Surat Pengajuan Pembelian Unit",
      "tgl": "Apr 19",
      "status": "Urgent",
      "progres": "Pending"
    },
  ];

  get getDataUser {
    return _allusers;
  }

  void addUser(user) {
    _allusers.add(user);
    notifyListeners();
  }
}
