import 'package:flutter/material.dart';
import 'package:project/Devon/history_page.dart';
import 'package:project/Devon/home_page.dart';
import 'package:project/Devon/dashboard.dart';
import 'package:project/hadron/login_screen.dart';
// import 'package:project/Devon/error_page.dart';
// import 'package:project/Devon/loading_page.dart';
// import 'package:project/Devon/maintenance_page.dart';
// import 'package:project/Devon/updating_page.dart';
import 'package:project/hadron/loginpage.dart';
import 'package:project/Devon/providers.dart';
import 'package:project/hadron/welcome_screen.dart';
import 'package:project/jerry/create-user.dart';
import 'package:project/jerrywijaya/profile.dart';
import 'package:project/tian/PengajuanSurat.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => Settings_provider(),
    ),
    ChangeNotifierProvider(
      create: (_) => UserListProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<Settings_provider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: prov.enableDarkMode == true ? prov.dark : prov.light,
      home: Welcome_screen(),
    );
  }
}
