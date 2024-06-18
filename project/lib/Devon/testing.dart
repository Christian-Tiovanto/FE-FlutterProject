import 'dart:async';
import 'package:flutter/material.dart';

class AutoCloseDialog extends StatefulWidget {
  @override
  _AutoCloseDialogState createState() => _AutoCloseDialogState();
}

class _AutoCloseDialogState extends State<AutoCloseDialog> {
  late Timer _timer;
  double _opacity = 1.0;

  @override
  void initState() {
    super.initState();
    // Atur timer untuk menutup dialog setelah 3 detik
    _timer = Timer(Duration(seconds: 3), () {
      setState(() {
        _opacity = 0.0; // Ubah opacity menjadi 0 untuk menghilangkan dialog
      });
      // Tunggu sedikit sebelum menutup dialog
      Timer(Duration(milliseconds: 500), () {
        Navigator.of(context).pop(); // Tutup dialog
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Batalkan timer saat widget di-dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: Duration(milliseconds: 500), // Durasi animasi menghilang
      curve: Curves.easeOut, // Kurva animasi
      child: AlertDialog(
        title: Text('Auto Close Dialog'),
        content: Text(
            'Ini adalah pesan dialog yang akan menghilang secara pelan-pelan.'),
      ),
    );
  }
}

void showAutoCloseDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AutoCloseDialog(),
  );
}
