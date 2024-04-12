import 'package:flutter/material.dart';
import 'package:project/tian/PengajuanSurat.dart';

void main() {
  runApp(PengajuanSurat());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
