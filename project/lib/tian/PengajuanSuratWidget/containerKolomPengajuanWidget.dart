import "package:flutter/material.dart";
import "package:flutter/widgets.dart";

class PaddingLeftAndRight {
  final double leftPadding;
  final double rightPadding;

  PaddingLeftAndRight({required this.leftPadding, required this.rightPadding});
}

class ContainerKolomPengajuanSuratWidget extends StatelessWidget {
  final Widget? firstPart;
  final Widget? secondPart;
  final Widget? thirdPart;
  final PaddingLeftAndRight containerPadding;
  const ContainerKolomPengajuanSuratWidget(
      {super.key,
      this.firstPart,
      this.secondPart,
      this.thirdPart,
      required this.containerPadding});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: containerPadding.leftPadding,
        ),
        Container(
          child: firstPart ??
              Container(
                color: Colors.black,
                width: 50,
                height: 50,
              ),
        ),
        SizedBox(
          width: containerPadding.rightPadding,
        ),
        Expanded(
          flex: 3,
          child: Container(
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
