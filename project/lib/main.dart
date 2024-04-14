import 'package:flutter/material.dart';
import 'package:project/tian/PengajuanSurat.dart';

void main() {
  runApp(PengajuanSurat());
}

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class DropdownMenuApp extends StatelessWidget {
  const DropdownMenuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: const Text('DropdownMenu Sample')),
        body: const Center(
          child: DropdownMenuExample(),
        ),
      ),
    );
  }
}

class DropdownMenuExample extends StatefulWidget {
  const DropdownMenuExample({super.key});

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return Container(
      child: DropdownMenu<String>(
        width: 300,
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.blue,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(60),
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          ),
        ),
        menuStyle: MenuStyle(
            backgroundColor: MaterialStateProperty.resolveWith(getColor)),
        initialSelection: list.first,
        onSelected: (String? value) {
          // This is called when the user selects an item.
          setState(() {
            dropdownValue = value!;
          });
        },
        dropdownMenuEntries:
            list.map<DropdownMenuEntry<String>>((String value) {
          return DropdownMenuEntry<String>(
              value: value,
              label: value,
              labelWidget: Text(
                value,
                textAlign: TextAlign.right,
              ));
        }).toList(),
      ),
    );
  }
}

class SelectedBorder extends RoundedRectangleBorder
    implements MaterialStateOutlinedBorder {
  const SelectedBorder();

  @override
  OutlinedBorder? resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.selected)) {
      return const RoundedRectangleBorder();
    }
    return null; // Defer to default value on the theme or widget.
  }
}
