import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constanins.dart';

class TempButton extends StatelessWidget {
  final VoidCallback press;
  bool isActive;
  Color activeColor;
  String label, svgSrc;

  TempButton(
      {Key? key,
      required this.press,
      required this.label,
      required this.svgSrc,
      required this.isActive,
      this.activeColor = primaryColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: press,
          child: AnimatedContainer(
            duration: defaultDuration,
            height: isActive ? 75 : 50,
            width: isActive ? 75 : 50,
            margin: const EdgeInsets.only(bottom: 8),
            curve: Curves.easeInOutBack,
            child: SvgPicture.asset(
              svgSrc,
              color: activeColor,
            ),
          ),
        ),
        AnimatedDefaultTextStyle(
          style: TextStyle(
              fontWeight: isActive ? FontWeight.w500 : FontWeight.w400,
              fontSize: isActive ? 18 : 16,
              color: activeColor),
          duration: defaultDuration,
          child: Text(
            label,
          ),
        ),
      ],
    );
  }
}
