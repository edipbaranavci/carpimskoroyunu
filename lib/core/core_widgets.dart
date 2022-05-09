import 'dart:async';
import 'package:carpimskoroyunu/constants.dart';
import 'package:carpimskoroyunu/models/get_datas.dart';
import 'package:carpimskoroyunu/models/share_utils.dart';
import 'package:carpimskoroyunu/pages/login_page.dart';
import 'package:carpimskoroyunu/utils/game_screens_updates.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:screenshot/screenshot.dart';
import 'package:slide_countdown/slide_countdown.dart';
import '../pages/screens/false_reply_screen.dart';

class ReplyContainer extends StatefulWidget {
  final String replyText;
  final String screenName;
  late Color? backColor;
  final bool? kontrol;

  ReplyContainer({
    Key? key,
    required this.screenName,
    required this.replyText,
    this.backColor = Colors.transparent,
    this.kontrol = false,
  }) : super(key: key);
  @override
  State<ReplyContainer> createState() => _ReplyContainerState();
}

class _ReplyContainerState extends State<ReplyContainer> {
  _trueReply() async {
    setState(() {
      widget.backColor = Colors.green;
    });
    await Future.delayed(const Duration(milliseconds: 500), () {
      GameScreensUpdates(widget.screenName).widgetUpdate();
    });
  }

  _falseReply() async {
    setState(() {
      widget.backColor = Colors.red;
    });
    await Future.delayed(const Duration(milliseconds: 350), () {
      int _skor = int.parse(Datas().read(widget.screenName));
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) =>
            FalseReplyScreenDialog().falseReply(_skor, widget.screenName),
      );
    });
  }

  _replyController() {
    if (widget.kontrol == true) {
      _trueReply();
      Datas().update(widget.screenName);
    } else
      // ignore: curly_braces_in_flow_control_structures
      _falseReply();
  }

  @override
  Widget build(BuildContext context) {
    Decoration _boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: widget.backColor,
      border: Border.all(
        color: Theme.of(context).primaryColor,
        width: 5,
      ),
    );

    return Padding(
      padding: GameScreenConstants.replyPadding,
      child: InkWell(
        onTap: _replyController,
        child: Container(
          width: MediaQuery.of(context).size.width / 3,
          //margin: GameScreenConstants.replyMargin,
          decoration: _boxDecoration,
          child: Center(
            child: ReplyTextWidgets(text: widget.replyText),
          ),
        ),
      ),
    );
  }
}

class ReplyTextWidgets extends StatelessWidget {
  final String text;
  const ReplyTextWidgets({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headline3,
    );
  }
}

class QuestionTextWidget extends StatelessWidget {
  final String question1;
  final String question2;

  const QuestionTextWidget({
    Key? key,
    required this.question1,
    required this.question2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Theme.of(context).primaryColor, width: 5)),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Center(
        child: Text(
          '$question1 x $question2 = ?',
          style: Theme.of(context)
              .textTheme
              .headline3
              ?.copyWith(color: Theme.of(context).bottomAppBarColor),
        ),
      ),
    );
  }
}

class CountDownWidget extends StatelessWidget {
  final int sure;
  const CountDownWidget({Key? key, required this.sure}) : super(key: key);

  _sureBitti() {
    //print('Süre Bitti');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SlideCountdownSeparated(
        onDone: _sureBitti,
        duration: Duration(seconds: sure),
        textStyle: TextStyle(color: Theme.of(context).bottomAppBarColor),
        decoration: const BoxDecoration(
          color: Colors.green,
        ),
      ),
    );
  }
}

class TurnBackButton extends StatelessWidget {
  TurnBackButton({
    Key? key,
  }) : super(key: key) {
    _initAd();
  }

  late InterstitialAd _interstitialAd;
  late bool _isLoadAd = false;
  final String _institialAdUnitId = '';
  void _initAd() {
    InterstitialAd.load(
        adUnitId: _institialAdUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
            onAdFailedToLoad: (error) {
              print(error.toString() + '\n' + ('-' * 100));
            },
            onAdLoaded: _onadLoaded));
  }

  void _onadLoaded(InterstitialAd ad) {
    _interstitialAd = ad;
    _isLoadAd = true;
    _interstitialAd.fullScreenContentCallback =
        FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
      _interstitialAd.dispose();
    }, onAdFailedToShowFullScreenContent: (ad, error) {
      _interstitialAd.dispose();
    });
  }

  _adsLoad() async {
    try {
      _interstitialAd.show();
    } catch (e) {
      print(e.toString() + '\n' + ('-' * 100));
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        _adsLoad();

        Get.offAll(
          () => InventoryScreen(),
          transition: Transition.leftToRight,
        );
      },
      icon: const Icon(
        Icons.chevron_left,
      ),
    );
  }
}

class SharedButton extends StatelessWidget {
  final ScreenshotController screenshotController;
  const SharedButton({
    Key? key,
    required this.screenshotController,
  }) : super(key: key);

  _shareWidget() async {
    await ShareWidgetUtils(screenshotController: screenshotController)
        .takeImageAndShare();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: SkorScreensConstants.buttonPadding,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Theme.of(context).primaryColor,
            side: BorderSide(
                color: Theme.of(context).bottomAppBarColor, width: 2),
          ),
          onPressed: _shareWidget,
          child: Padding(
            padding: SkorScreensConstants.buttonContentPadding,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.share),
                Padding(
                  padding: SkorScreensConstants.buttonTitleLeftPadding,
                  child: Text(
                    SkorScreensConstants.sharedButtonTitle,
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                          color: Theme.of(context).bottomAppBarColor,
                        ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

class SkorsPagesContent extends StatelessWidget {
  final String title;
  final String scor;
  final Color backColor;
  const SkorsPagesContent({
    Key? key,
    required this.title,
    required this.scor,
    required this.backColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: backColor,
      ),
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline5
                ?.copyWith(color: Theme.of(context).bottomAppBarColor),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            scor,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: Theme.of(context).hintColor),
          ),
        ],
      ),
    );
  }
}

class SkorsPageTitleWidget extends StatelessWidget {
  const SkorsPageTitleWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      SkorScreensConstants.appBarTitle,
      style: Theme.of(context).textTheme.headline5,
    );
  }
}
