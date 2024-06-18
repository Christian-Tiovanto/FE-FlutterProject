import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:project/Devon/home_page.dart';
import 'package:project/Devon/providers.dart';
import 'package:project/Devon/switch_provider.dart';
import 'package:project/hadron/loginpage.dart';
import 'package:project/hadron/welcome_screen.dart';
import 'package:project/tian/LetterContentWidget.dart';
import 'package:project/tian/PengajuanSurat.dart';
import 'package:project/tian/PengajuanSuratWidget/searchUserWidget.dart';
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
