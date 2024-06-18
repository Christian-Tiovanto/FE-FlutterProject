import 'package:flutter/material.dart';

class TextFieldExample extends StatefulWidget {
  final bool isBorder;
  const TextFieldExample({super.key, required this.isBorder});

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
    return TextField(
      scrollPhysics: const NeverScrollableScrollPhysics(),
      decoration: InputDecoration(
          hintText: "Subject",
          border:
              widget.isBorder ? const UnderlineInputBorder() : InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 8)),
      maxLines: null,
      controller: _controller,
    );
  }
}
