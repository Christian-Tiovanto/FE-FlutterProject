import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/Devon/providers.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  Future getAllUsers() async {
    print('getAllUsers');
    final prefs = await SharedPreferences.getInstance();
    final url = Uri.parse("http://localhost:3000/api/v1/users/list-all-users");
    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": prefs.getString('token')!
        },
      );
      if (response.statusCode == 200) {
        print('userList');
        List results = jsonDecode(response.body)['data'];
        List<User> userList =
            List<User>.from(results.map((value) => User.fromJson(value)));
        print(userList);
        return userList;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future login(String name, String password, BuildContext context) async {
    final prov = Provider.of<Settings_provider>(context, listen: false);
    final prefs = await SharedPreferences.getInstance();
    final url = Uri.parse("http://localhost:3000/api/v1/users/login");
    try {
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body:
              jsonEncode(<String, String>{"nik": name, "password": password}));
      if (response.statusCode == 200) {
        prefs.setString("token", jsonDecode(response.body)['token']);
        AwesomeDialogCall(
            context, 'Your Login is Succeed', true, prov.enableDarkMode);
        return true;
      } else {
        AwesomeDialogCall(
            context, 'Your Login is Failed', false, prov.enableDarkMode);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

class LetterService {
  Future updateLetterRecipientStatus(letterId, recipientResponse) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final url = Uri.parse(
          'http://localhost:3000/api/v1/letters/$letterId/recipient-checked/$recipientResponse');
      final response = await http.put(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": prefs.getString('token')!
      });
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future postUserLetter(subject, description, priority, recipients) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final url = Uri.parse("http://localhost:3000/api/v1/letters/");
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "Authorization": prefs.getString('token')!
          },
          body: jsonEncode(<String, dynamic>{
            "subject": subject,
            "description": description,
            "priority": priority,
            "recipients": recipients
          }));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future getUserLetter() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final url = Uri.parse(
          "http://localhost:3000/api/v1/letters/current-user?checkedStatusIsRequest=true&status=ongoing");
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": prefs.getString('token')!
        },
      );
      List results = jsonDecode(response.body)['letters'];
      List<Mail> lettersList =
          List<Mail>.from(results.map((value) => Mail.fromJson(value)));
      return lettersList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future getUserCreatedLetter(status) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final url = Uri.parse(
          "http://localhost:3000/api/v1/letters/userCreatedLetters/$status");
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": prefs.getString('token')!
        },
      );
      List results = jsonDecode(response.body)['data'];
      print(results);
      List<MailSent> lettersList =
          List<MailSent>.from(results.map((value) => MailSent.fromJson(value)));
      print(lettersList);
      return lettersList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

void AwesomeDialogCall(
    BuildContext context, String message, bool login, bool prov) {
  AwesomeDialog(
    context: context,
    animType: AnimType.scale,
    dialogType: DialogType.success,
    body: Center(
      child: Text(
        message,
        style: TextStyle(
            color: prov ? Colors.white : Colors.black,
            fontStyle: FontStyle.italic),
      ),
    ),
    title: 'This is Ignored',
    desc: 'This is also Ignored',
    btnOkColor: login ? Colors.green : Colors.red,
    btnOkOnPress: login
        ? () {
            Navigator.pushNamed(context, "/HomeScreen");
            print('terlogin');
          }
        : () {},
  ).show();
}
