import 'package:flutter/material.dart';
import 'package:project/hadron/loginpage.dart';
import 'package:project/homeandhistory/pertemuan_06provider.dart';
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
