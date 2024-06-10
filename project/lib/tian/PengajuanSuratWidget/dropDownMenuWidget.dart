import 'package:flutter/material.dart';

const List<String> list = <String>['Sudah Diputuskan', 'Sudah Diberi Arahan'];

class DropdownMenuExample extends StatefulWidget {
  final List<String>? listData;
  const DropdownMenuExample({super.key, this.listData});

  @override
  State<DropdownMenuExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownMenuExample> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 500, maxWidth: 200),
      child: DropdownButton<String>(
        value: dropdownValue,
        isDense: true,
        isExpanded: true,
        underline: Text(""),
        style: const TextStyle(color: Colors.deepPurple, fontSize: 15),
        onChanged: (String? value) {
          // This is called when the user selects an item.
          setState(() {
            dropdownValue = value!;
          });
        },
        items: list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: ConstrainedBox(
              constraints: BoxConstraints.tightFor(width: 200),
              child: Container(
                child: Text(value),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
