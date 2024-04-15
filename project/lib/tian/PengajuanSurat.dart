import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class PengajuanSurat extends StatefulWidget {
  const PengajuanSurat({super.key});

  @override
  State<PengajuanSurat> createState() => _PengajuanSuratState();
}

class _PengajuanSuratState extends State<PengajuanSurat> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: const _PengajuanSuratAppBarWidget(),
        body: Column(
          children: [
            ContainerKolomPengajuanSuratWidget(
              leadingText: "Dari",
              titleContent: Text('One-linea with trailing widget',
                  style: TextStyle(height: 1, fontSize: 15)),
              trailingContent: Icon(Icons.keyboard_arrow_down_outlined),
            ),
            ContainerKolomPengajuanSuratWidget(
              leadingText: "Kepada",
              titleContent: Text('One-linea with trailing widget',
                  style: TextStyle(height: 1, fontSize: 15)),
              trailingContent: Icon(Icons.keyboard_arrow_down_outlined),
            ),
            ContainerKolomPengajuanSuratWidget(
              leadingText: "Jenis Surat",
              trailingContent: DropdownMenuExample(
                ListData: ['1', '2', '3'],
              ),
            ),
          ],
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ContainerKolomPengajuanSuratWidget extends StatelessWidget {
  final String leadingText;
  final Widget? titleContent;
  final Widget? trailingContent;
  const ContainerKolomPengajuanSuratWidget(
      {super.key,
      this.leadingText = "text",
      this.titleContent,
      this.trailingContent});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      decoration:
          const BoxDecoration(border: Border(bottom: BorderSide(width: 1))),
      child: SizedBox(
        height: 40,
        child: ListTile(
          horizontalTitleGap: 30,
          titleAlignment: ListTileTitleAlignment.center,
          leading: Text(
            this.leadingText,
            style: TextStyle(fontSize: 15, height: 1),
          ),
          title: this.titleContent,
          trailing: this.trailingContent,
        ),
      ),
    );
  }
}

class _PengajuanSuratAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const _PengajuanSuratAppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.pink,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Icon(IconData(0xe0b3, fontFamily: 'MaterialIcons')),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: RotatedBox(
            quarterTurns: 3,
            child: Icon(IconData(0xe571,
                fontFamily: 'MaterialIcons', matchTextDirection: true)),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class DropdownMenuExample extends StatefulWidget {
  final List<String>? ListData;
  const DropdownMenuExample({super.key, this.ListData});

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  late String dropdownValue = widget.ListData!.first;

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
        textStyle: TextStyle(height: 1),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.blue,
          filled: true,
          isDense: true,
          constraints: BoxConstraints.tight(Size.fromHeight(30)),
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
        initialSelection: widget.ListData!.first,
        onSelected: (String? value) {
          // This is called when the user selects an item.
          setState(() {
            dropdownValue = value!;
          });
        },
        dropdownMenuEntries:
            widget.ListData!.map<DropdownMenuEntry<String>>((String value) {
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
