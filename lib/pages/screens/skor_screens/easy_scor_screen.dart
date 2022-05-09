import 'package:carpimskoroyunu/constants.dart';
import 'package:carpimskoroyunu/core/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

class EasyGameScorScreen extends StatelessWidget {
  final String scor;
  EasyGameScorScreen({Key? key, required this.scor}) : super(key: key);

  final _screenshotController = ScreenshotController();

  final Color _backColor = Colors.green;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Scaffold(
        backgroundColor: _backColor,
        body: Center(
          child: Column(
            children: [
              const Spacer(),
              Screenshot(
                controller: _screenshotController,
                child: SkorsPagesContent(
                  backColor: _backColor,
                  title: SkorScreensConstants.easyModTitle,
                  scor: scor,
                ),
              ),
              const Spacer(),
              SharedButton(
                screenshotController: _screenshotController,
              )
            ],
          ),
        ),
      ),
    );
  }
}
