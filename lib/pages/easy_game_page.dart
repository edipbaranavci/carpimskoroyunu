// ignore_for_file: unrelated_type_equality_checks

import 'dart:math';
import 'package:carpimskoroyunu/constants.dart';
import 'package:carpimskoroyunu/core/ads_widgets.dart';
import 'package:carpimskoroyunu/core/core_widgets.dart';
import 'package:carpimskoroyunu/utils/easy_game_inventory.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class EasyGameScreen extends StatefulWidget {
  const EasyGameScreen({Key? key}) : super(key: key);

  void alert() {}

  void yenile() {
    _EasyGameScreenState()._tekrarYap();
  }

  @override
  State<EasyGameScreen> createState() => _EasyGameScreenState();
}

class _EasyGameScreenState extends State<EasyGameScreen> {
  late int _random;

  @override
  void initState() {
    super.initState();
    _tekrarYap();
  }

  void _tekrarYap() {
    setState(() {
      _random = Random().nextInt(20);
      _veriCek();
      _listeOlustur();
    });
  }

  void _veriCek() {
    try {
      GameScreenConstants.a = EasyGameInventory().listele();

      GameScreenConstants.question1 =
          GameScreenConstants.a[_random][0].toString();
      GameScreenConstants.question2 =
          GameScreenConstants.a[_random][1].toString();
      GameScreenConstants.reply = GameScreenConstants.a[_random][2].toString();
      GameScreenConstants.fakeReply1 =
          GameScreenConstants.a[_random][3].toString();
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  void _listeOlustur() {
    GameScreenConstants.gonder.clear();
    GameScreenConstants.gonder.addAll({
      [GameScreenConstants.reply, true],
      [GameScreenConstants.fakeReply1, false]
    });
    GameScreenConstants.gonder.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CountDownWidget(
          sure: GameScreenConstants.gameScreenCountDown,
        ),
        centerTitle: true,
        leading: TurnBackButton(),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              QuestionTextWidget(
                question1: GameScreenConstants.question1,
                question2: GameScreenConstants.question2,
              ),
              const Spacer(),
              const AdsWidgets(adsWidgetTwo: true),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ReplyContainer(
                    screenName: GameScreenConstants.easyGameScreenName,
                    replyText: GameScreenConstants.gonder[0][0],
                    kontrol: GameScreenConstants.gonder[0][1],
                  ),
                  ReplyContainer(
                    screenName: GameScreenConstants.easyGameScreenName,
                    replyText: GameScreenConstants.gonder[1][0],
                    kontrol: GameScreenConstants.gonder[1][1],
                  ),
                ],
              ),
              const AdsWidgets(adsWidgetTwo: false),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
