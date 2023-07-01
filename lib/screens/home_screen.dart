import 'package:car_controller_animation/components/door_lock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../components/tesla_bottom_navigation.dart';
import '../constanins.dart';
import '../home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final HomeController _controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) => Scaffold(
        bottomNavigationBar: TeslaBottomNavigation(
          onTap: (index) {
            _controller.onBottomNavigationTabChange(index);
          },
          selectedIndex: _controller.selectedBottomTab,
        ),
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
                AnimatedPositioned(
                  left: _controller.selectedBottomTab == 0
                      ? constraints.maxWidth * 0.05
                      : constraints.maxWidth / 2,
                  duration: defaultDuration,
                  child: AnimatedOpacity(
                    opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                    duration: defaultDuration,
                    child: DoorLock(
                        onPress: _controller.updateLeftDoor,
                        isLock: _controller.isLeftDoorLock),
                  ),
                ),
                AnimatedPositioned(
                  duration: defaultDuration,
                  right: _controller.selectedBottomTab == 0
                      ? constraints.maxWidth * 0.05
                      : constraints.maxWidth / 2,
                  child: AnimatedOpacity(
                    duration: defaultDuration,
                    opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                    child: DoorLock(
                        onPress: _controller.updateRightDoor,
                        isLock: _controller.isRightDoorLock),
                  ),
                ),
                AnimatedPositioned(
                  duration: defaultDuration,
                  top: _controller.selectedBottomTab == 0
                      ? constraints.maxHeight * 0.13
                      : constraints.maxHeight / 2,
                  child: AnimatedOpacity(
                    duration: defaultDuration,
                    opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                    child: DoorLock(
                        onPress: _controller.updateBonnetDoor,
                        isLock: _controller.isBonnetDoorLock),
                  ),
                ),
                AnimatedPositioned(
                  duration: defaultDuration,
                  bottom: _controller.selectedBottomTab == 0
                      ? constraints.maxHeight * 0.17
                      : constraints.maxHeight / 2,
                  child: AnimatedOpacity(
                    duration: defaultDuration,
                    opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                    child: DoorLock(
                        onPress: _controller.updateTrunkDoor,
                        isLock: _controller.isTrunkDoorLock),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
