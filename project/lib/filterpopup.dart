import 'package:flutter/material.dart';

class FilterPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Implementasikan UI opsi filter Anda di sini
    return AlertDialog(
      title: Text('Opsi Filter'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            // Tambahkan widget opsi filter Anda di sini
            // Contoh:
            CheckboxListTile(
              title: Text('Opsi 1'),
              value: true,
              onChanged: (value) {},
            ),
            CheckboxListTile(
              title: Text('Opsi 2'),
              value: false,
              onChanged: (value) {},
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Tutup pop-up filter
          },
          child: Text('Terapkan'),
        ),
      ],
    );
  }
}
