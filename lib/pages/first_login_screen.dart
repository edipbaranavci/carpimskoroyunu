import 'package:carpimskoroyunu/models/hive_datas.dart';
import 'package:carpimskoroyunu/pages/inventory_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../constants.dart';

class FirstLoginScreen extends StatelessWidget {
  const FirstLoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //bottomNavigationBar: _StartButton(title: _buttonTitle),
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const _WelcomeImage(),
          _TitleWidgets(
            title: FirstLoginScreenStrings.title,
            textColor: Theme.of(context).hintColor,
          ),
          _TitleWidgets(
            title: FirstLoginScreenStrings.description,
            textColor: Theme.of(context).hintColor,
          ),
          const Spacer(),
          const _StartButton(title: FirstLoginScreenStrings.buttonTitle),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class _StartButton extends StatefulWidget {
  final String title;
  const _StartButton({Key? key, required this.title}) : super(key: key);

  @override
  State<_StartButton> createState() => _StartButtonState();
}

class _StartButtonState extends State<_StartButton> {
  void _login() {
    HiveDatas().firstLogin();
    Get.offAll(() => const InventoryScreen(), transition: Transition.fadeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _FirstScreenConstants.startButtonPadding,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
            side: const BorderSide(
              color: Colors.amber,
              width: 3,
            ),
          ),
          onPressed: _login,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(FontAwesomeIcons.google),
              const SizedBox(
                width: 10,
              ),
              _TitleWidgets(
                  title: widget.title,
                  textColor: Theme.of(context).bottomAppBarColor),
              const Icon(Icons.chevron_right),
            ],
          )),
    );
  }
}

class _TitleWidgets extends StatelessWidget {
  final String title;
  final Color? textColor;
  const _TitleWidgets({
    Key? key,
    required this.title,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _FirstScreenConstants.titleTextPadding,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline6?.copyWith(
              color: textColor,
            ),
      ),
    );
  }
}

class _WelcomeImage extends StatelessWidget {
  const _WelcomeImage({
    Key? key,
  }) : super(key: key);

  final String _welcomeImagePath = 'assets/images/welcome_screen_img.png';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _FirstScreenConstants.imagePadding,
      child: Image.asset(_welcomeImagePath),
    );
  }
}

class _FirstScreenConstants {
  static const imagePadding = EdgeInsets.all(40.0);
  static const startButtonPadding = EdgeInsets.symmetric(horizontal: 10);
  static const titleTextPadding =
      EdgeInsets.symmetric(horizontal: 15, vertical: 15);
}
