import "package:flutter/material.dart";

class ContainerKolomPengajuanSuratWidget extends StatelessWidget {
  final Widget? firstPart;
  final Widget? secondPart;
  final Widget? thirdPart;
  const ContainerKolomPengajuanSuratWidget(
      {super.key, this.firstPart, this.secondPart, this.thirdPart});

  @override
  Widget build(BuildContext context) {
    return
        // color: Colors.black,
        Row(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: firstPart ??
              Container(
                color: Colors.black,
                width: 50,
                height: 50,
              ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            color: Colors.black,
            child: secondPart ??
                const SizedBox(
                  width: 0,
                  height: 0,
                ),
          ),
        ),
        Container(
          child: thirdPart ??
              const SizedBox(
                width: 0,
                height: 0,
              ),
        ),
      ],
    );
  }
}
