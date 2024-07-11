import 'package:flutter/material.dart';
import 'package:project/Devon/providers.dart';
import 'package:provider/provider.dart';

class TextFieldExample extends StatefulWidget {
  final bool isBorder;
  final String title;
  List subjectValue;
  TextFieldExample({
    required this.subjectValue,
    super.key,
    required this.isBorder,
    required this.title,
  });

  @override
  State<TextFieldExample> createState() => _TextFieldExampleState();
}

class _TextFieldExampleState extends State<TextFieldExample> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.subjectValue[0] = " ";
    return TextField(
      onChanged: (value) {
        widget.subjectValue[0] = value;
      },
      scrollPhysics: const NeverScrollableScrollPhysics(),
      decoration: InputDecoration(
          hintText: widget.title,
          border:
              widget.isBorder ? const UnderlineInputBorder() : InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 8)),
      maxLines: null,
      controller: _controller,
    );
  }
}
