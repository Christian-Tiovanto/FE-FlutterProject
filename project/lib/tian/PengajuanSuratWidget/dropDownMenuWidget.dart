import 'package:flutter/material.dart';
import 'package:project/Devon/providers.dart';
import 'package:provider/provider.dart';

class DropdownMenuExample extends StatefulWidget {
  final List<String> listData;
  String value;
  DropdownMenuExample({super.key, required this.listData, required this.value});

  @override
  State<DropdownMenuExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownMenuExample> {
  late String dropdownValue;
  @override
  void initState() {
    super.initState();
    dropdownValue = widget.listData.first; // Access 'widget' here
  }

  @override
  Widget build(BuildContext context) {
    final PrioritasSuratValue = Provider.of<MailValue>(context).mailPriority;
    final responseSuratValue = Provider.of<MailValue>(context).responseSurat;
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 500, maxWidth: 200),
      child: DropdownButton<String>(
        value: dropdownValue,
        isDense: true,
        isExpanded: true,
        underline: const Text(""),
        style: const TextStyle(color: Colors.deepPurple, fontSize: 15),
        onChanged: (String? value) {
          // This is called when the user selects an item.
          setState(() {
            PrioritasSuratValue[0] = value!;
            widget.value = value;
            responseSuratValue[0] = value;
            print('PrioritasSuratValue');
            print(widget.value);
            print(PrioritasSuratValue);
            dropdownValue = value;
          });
        },
        items: widget.listData.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: ConstrainedBox(
              constraints: const BoxConstraints.tightFor(width: 200),
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
