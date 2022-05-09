import 'package:get/get.dart';

import '../pages/easy_game_page.dart';
import '../pages/hard_game_page.dart';
import '../pages/normal_game_page.dart';

class GameScreensUpdates {
  final String screenCount;
  GameScreensUpdates(this.screenCount);
  void widgetUpdate() {
    if (screenCount == 'easy') {
      Get.offAll(() => const EasyGameScreen(),
          transition: Transition.noTransition);
    } else if (screenCount == 'normal') {
      Get.offAll(() => const NormalGameScreen(),
          transition: Transition.noTransition);
    } else if (screenCount == 'hard') {
      Get.offAll(() => const HardGameScreen(),
          transition: Transition.noTransition);
    }
  }
}
