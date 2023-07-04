import 'package:car_controller_animation/components/door_lock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../components/tesla_bottom_navigation.dart';
import '../constanins.dart';
import '../home_controller.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final HomeController _controller = HomeController();

  late AnimationController _batterAnimationController;
  late AnimationController _tempAnimationController;

  late Animation<double> _animationBattery;
  late Animation<double> _animationBatteryStatus;
  late Animation<double> _animationCarShift;

  void setUpBatteryAnimation() {
    _batterAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _animationBattery = CurvedAnimation(
        parent: _batterAnimationController, curve: const Interval(0.0, 0.5));
    _animationBatteryStatus = CurvedAnimation(
        parent: _batterAnimationController, curve: const Interval(0.6, 1));
  }

  void setUpTempAnimation() {
    _tempAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900));
    _animationCarShift = CurvedAnimation(
        parent: _tempAnimationController, curve: const Interval(0.2, 0.4));
  }

  @override
  void initState() {
    super.initState();
    setUpBatteryAnimation();
    setUpTempAnimation();
  }

  @override
  void dispose() {
    super.dispose();
    _batterAnimationController.dispose();
    _tempAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge(
          [_controller, _batterAnimationController, _tempAnimationController]),
      builder: (BuildContext context, Widget? child) => Scaffold(
        bottomNavigationBar: TeslaBottomNavigation(
          onTap: (index) {
            if (index == 1) {
              _batterAnimationController.forward();
            } else if (index != 1) {
              _batterAnimationController.reverse();
            }
            if (index == 2) {
              _tempAnimationController.forward();
            } else if (_controller.selectedBottomTab == 2 && index != 2) {
              _tempAnimationController.reverse(from: 0.4);
            }
            _controller.onBottomNavigationTabChange(index);
          },
          selectedIndex: _controller.selectedBottomTab,
        ),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) => Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                ),
                Positioned(
                  left: constraints.maxWidth / 2 * (_animationCarShift.value),
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: constraints.maxHeight * 0.1),
                    child: SvgPicture.asset(
                      'assets/icons/Car.svg',
                      width: double.infinity,
                    ),
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
                AnimatedOpacity(
                  duration: defaultDuration,
                  opacity: _animationBattery.value,
                  child: SvgPicture.asset(
                    'assets/icons/Battery.svg',
                    width: constraints.maxWidth * 0.45,
                  ),
                ),
                Positioned(
                  top: 50 * (1 - _animationBatteryStatus.value),
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                  child: AnimatedOpacity(
                    duration: defaultDuration,
                    opacity: _animationBatteryStatus.value,
                    child: Column(
                      children: [
                        SizedBox(
                          height: constraints.maxHeight * 0.01,
                        ),
                        Text(
                          '220 mi',
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        Text(
                          '62 %',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        const Spacer(),
                        Text('charging'.toUpperCase(),
                            style: const TextStyle(fontSize: 20)),
                        Text('18 min remaining'.toUpperCase(),
                            style: const TextStyle(fontSize: 18)),
                        SizedBox(
                          height: constraints.maxHeight * 0.14,
                        ),
                        DefaultTextStyle(
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text('22 mi/hr'),
                                Text('232v'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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
