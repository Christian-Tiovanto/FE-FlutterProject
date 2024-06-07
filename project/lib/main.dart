import 'package:flutter/material.dart';
import 'package:project/Devon/error_page.dart';
import 'package:project/Devon/loading_page.dart';
import 'package:project/Devon/maintenance_page.dart';
import 'package:project/Devon/updating_page.dart';
import 'package:project/hadron/loginpage.dart';
import 'package:project/Devon/switch_provider.dart';
import 'package:project/tian/PengajuanSurat.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => Pertemuan06Provider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<Pertemuan06Provider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: prov.enableDarkMode == true ? prov.dark : prov.light,
      home: WelcomePage(),
    );
  }
}
