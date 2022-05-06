import 'package:get/get.dart';

import '../pages/easy_game_screen.dart';
import '../pages/hard_game_screen.dart';
import '../pages/normal_game_screen.dart';

class GameScreensUpdates {
  final int screenCount;
  GameScreensUpdates(this.screenCount);
  void widgetUpdate() {
    if (screenCount == 0) {
      Get.offAll(() => const EasyGameScreen(),
          transition: Transition.noTransition);
    } else if (screenCount == 1) {
      Get.offAll(() => const NormalGameScreen(),
          transition: Transition.noTransition);
    } else if (screenCount == 2) {
      Get.offAll(() => const HardGameScreen(),
          transition: Transition.noTransition);
    }
  }
}
