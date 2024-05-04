import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/tian/PengajuanSurat.dart';

/// Flutter code sample for [MenuAnchor].

void main() => runApp(const PengajuanSurat());

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class MyCascadingMenu extends StatefulWidget {
  const MyCascadingMenu({super.key, required this.message});

  final String message;

  @override
  State<MyCascadingMenu> createState() => _MyCascadingMenuState();
}

class _MyCascadingMenuState extends State<MyCascadingMenu> {
  String _lastSelection = list[0];
  final FocusNode _buttonFocusNode = FocusNode(debugLabel: 'Menu Button');

  @override
  void dispose() {
    _buttonFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        MenuAnchor(
          childFocusNode: _buttonFocusNode,
          menuChildren: List<Widget>.generate(
              list.length,
              (index) => SizedBox(
                    width: 200,
                    child: MenuItemButton(
                        onPressed: () => setState(() {
                              _lastSelection = list[index];
                            }),
                        child: Text(list[index])),
                  )),
          builder:
              (BuildContext context, MenuController controller, Widget? child) {
            return TextButton(
              style: ButtonStyle(
                  padding: MaterialStatePropertyAll(EdgeInsets.all(0))),
              focusNode: _buttonFocusNode,
              onPressed: () {
                if (controller.isOpen) {
                  controller.close();
                } else {
                  controller.open();
                }
              },
              child: SizedBox(
                  width: 200, child: Center(child: Text(_lastSelection))),
            );
          },
        ),
      ],
    );
  }
}

class MenuApp extends StatelessWidget {
  const MenuApp({super.key});

  static const String kMessage = '"Talk less. Smile more." - A. Burr';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const Scaffold(
          body: SafeArea(child: MyCascadingMenu(message: kMessage))),
    );
  }
}
