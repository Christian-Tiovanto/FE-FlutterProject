import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  Future login(String name, String password, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final url = Uri.parse("http://localhost:3000/api/v1/users/login");
    try {
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
              <String, String>{"email": name, "password": password}));
      if (response.statusCode == 200) {
        prefs.setString("token", jsonDecode(response.body)['token']);
        AwesomeDialog(
          context: context,
          animType: AnimType.scale,
          dialogType: DialogType.success,
          body: Center(
            child: Text(
              'Your Login Is Succeed',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          title: 'This is Ignored',
          desc: 'This is also Ignored',
          btnOkOnPress: () {
            Navigator.pushNamed(context, "/HomeScreen");
            print('terlogin');
          },
        ).show();
        return true;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
