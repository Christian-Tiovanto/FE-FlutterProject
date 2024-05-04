import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Flutter code sample for [MenuAnchor].

void main() => runApp(const MenuApp());

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

/// An enhanced enum to define the available menus and their shortcuts.
///
/// Using an enum for menu definition is not required, but this illustrates how
/// they could be used for simple menu systems.
enum MenuEntry {
  about('About'),
  showMessage(
    'Show Message',
  ),
  hideMessage(
    'Hide Message',
  ),
  colorMenu('Color Menu'),
  colorRed(
    'Red Background',
  ),
  colorGreen(
    'Green Background',
  ),
  colorBlue(
    'Blue Background',
  );

  const MenuEntry(this.label);
  final String label;
}

class MyCascadingMenu extends StatefulWidget {
  const MyCascadingMenu({super.key, required this.message});

  final String message;

  @override
  State<MyCascadingMenu> createState() => _MyCascadingMenuState();
}

class _MyCascadingMenuState extends State<MyCascadingMenu> {
  String _lastSelection = list[0];
  final FocusNode _buttonFocusNode = FocusNode(debugLabel: 'Menu Button');

  Color get backgroundColor => _backgroundColor;
  Color _backgroundColor = Colors.red;
  set backgroundColor(Color value) {
    if (_backgroundColor != value) {
      setState(() {
        _backgroundColor = value;
      });
    }
  }

  bool get showingMessage => _showingMessage;
  bool _showingMessage = false;
  set showingMessage(bool value) {
    if (_showingMessage != value) {
      setState(() {
        _showingMessage = value;
      });
    }
  }

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
