import 'package:car_controller_animation/components/door_lock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../components/tesla_bottom_navigation.dart';
import '../home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final HomeController _controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) => Scaffold(
        bottomNavigationBar: TeslaBottomNavigation(onTap: (index){},selectedIndex: 0,),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) => Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: constraints.maxHeight * 0.1),
                  child: SvgPicture.asset(
                    'assets/icons/Car.svg',
                    width: double.infinity,
                  ),
                ),
                Positioned(
                  left: constraints.maxWidth * 0.05,
                  child: DoorLock(
                      onPress: _controller.updateLeftDoor,
                      isLock: _controller.isLeftDoorLock),
                ),
                Positioned(
                  right: constraints.maxWidth * 0.05,
                  child: DoorLock(
                      onPress: _controller.updateRightDoor,
                      isLock: _controller.isRightDoorLock),
                ),
                Positioned(
                  top: constraints.maxHeight * 0.13,
                  child: DoorLock(
                      onPress: _controller.updateBonnetDoor,
                      isLock: _controller.isBonnetDoorLock),
                ),
                Positioned(
                  bottom: constraints.maxHeight * 0.13,
                  child: DoorLock(
                      onPress: _controller.updateTrunkDoor,
                      isLock: _controller.isTrunkDoorLock),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
