import 'package:flutter/foundation.dart';

class HomeController extends ChangeNotifier {
  bool isLeftDoorLock = true;
  bool isRightDoorLock = true;
  bool isBonnetDoorLock = true;
  bool isTrunkDoorLock = true;

  int selectedBottomTab = 0;

  onBottomNavigationTabChange(int index) {
    selectedBottomTab = index;
    notifyListeners();
  }

  updateLeftDoor() {
    isLeftDoorLock = !isLeftDoorLock;
    notifyListeners();
  }

  updateRightDoor() {
    isRightDoorLock = !isRightDoorLock;
    notifyListeners();
  }

  updateBonnetDoor() {
    isBonnetDoorLock = !isBonnetDoorLock;
    notifyListeners();
  }

  updateTrunkDoor() {
    isTrunkDoorLock = !isTrunkDoorLock;
    notifyListeners();
  }
}
