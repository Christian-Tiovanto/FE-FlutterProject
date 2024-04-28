import 'package:flutter/material.dart';

class DropdownMenuExample extends StatefulWidget {
  final List<String>? listData;
  const DropdownMenuExample({super.key, this.listData});

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  late String dropdownValue = widget.listData!.first;

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
      // height: 5,
      color: Colors.black,
      child: DropdownMenu<String>(
        width: 200,
        textStyle: const TextStyle(height: 1),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.blue,
          filled: true,
          isDense: true,
          constraints: BoxConstraints.tight(const Size.fromHeight(30)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(60),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          ),
        ),
        menuStyle: MenuStyle(
            backgroundColor: MaterialStateProperty.resolveWith(getColor)),
        initialSelection: widget.listData!.first,
        onSelected: (String? value) {
          // This is called when the user selects an item.
          setState(() {
            dropdownValue = value!;
          });
        },
        dropdownMenuEntries:
            widget.listData!.map<DropdownMenuEntry<String>>((String value) {
          return DropdownMenuEntry<String>(
              value: value,
              label: value,
              labelWidget: Text(
                value,
              ));
        }).toList(),
      ),
    );
  }
}
