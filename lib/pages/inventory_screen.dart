import 'package:carpimskoroyunu/pages/easy_game_screen.dart';
import 'package:carpimskoroyunu/pages/hard_game_screen.dart';
import 'package:carpimskoroyunu/pages/normal_game_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({Key? key}) : super(key: key);

  final String _kolay = 'Kolay';
  final String _normal = 'Normal';
  final String _zor = 'Zor';
  final String _skorum = 'Skorlarım';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _InventoryButtons(
              function: () => Get.to(() => const EasyGameScreen(),
                  transition: Transition.rightToLeft),
              buttonTitle: _kolay,
            ),
            _InventoryButtons(
              function: () => Get.to(() => const NormalGameScreen(),
                  transition: Transition.rightToLeft),
              buttonTitle: _normal,
            ),
            _InventoryButtons(
              function: () => Get.to(() => const HardGameScreen(),
                  transition: Transition.rightToLeft),
              buttonTitle: _zor,
            ),
            _InventoryButtons(
              function: () {},
              buttonTitle: _skorum,
            ),
          ],
        ),
      ),
    );
  }
}

class _InventoryButtons extends StatelessWidget {
  final String buttonTitle;
  final void Function()? function;
  const _InventoryButtons({
    Key? key,
    required this.buttonTitle,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ButtonStyle customElevatedButtonStyle = ElevatedButton.styleFrom(
      primary: Theme.of(context).primaryColor,
    );

    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.7,
      child: ElevatedButton(
        style: customElevatedButtonStyle,
        onPressed: function,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              buttonTitle,
              style: Theme.of(context).textTheme.headline4?.copyWith(
                    color: Theme.of(context).bottomAppBarColor,
                  ),
            ),
            Icon(
              Icons.chevron_right,
              color: Theme.of(context).bottomAppBarColor,
            )
          ],
        ),
      ),
    );
  }
}
