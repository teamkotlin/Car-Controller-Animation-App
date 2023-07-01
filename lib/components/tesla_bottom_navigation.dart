import 'package:car_controller_animation/constanins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TeslaBottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  TeslaBottomNavigation(
      {Key? key, required this.selectedIndex, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: onTap,
      currentIndex: selectedIndex,
      type: BottomNavigationBarType.fixed,
      items: List.generate(
          svgSrc.length,
          (index) => BottomNavigationBarItem(
              icon: SvgPicture.asset(
                svgSrc[index],
                color: selectedIndex == index ? primaryColor : Colors.white54,
              ),
              label: "")),
    );
  }

  List<String> svgSrc = [
    "assets/icons/Lock.svg",
    "assets/icons/Charge.svg",
    "assets/icons/Temp.svg",
    "assets/icons/Tyre.svg",
  ];
}
