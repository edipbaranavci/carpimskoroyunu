import 'package:carpimskoroyunu/pages/hard_game_screen.dart';
import 'package:carpimskoroyunu/pages/normal_game_screen.dart';

import '../pages/easy_game_screen.dart';

class GameScreensAlerts {
  final int screenCount;
  GameScreensAlerts(this.screenCount);
  void alertGonder() {
    if (screenCount == 0) {
      const EasyGameScreen().alert();
    } else if (screenCount == 1) {
      const NormalGameScreen().alert();
    } else if (screenCount == 2) {
      const HardGameScreen().alert();
    }
  }
}
