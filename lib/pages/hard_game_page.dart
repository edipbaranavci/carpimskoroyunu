import 'dart:math';

import 'package:carpimskoroyunu/core/core_widgets.dart';
import 'package:carpimskoroyunu/utils/hard_game_inventory.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../constants.dart';

class HardGameScreen extends StatefulWidget {
  const HardGameScreen({Key? key}) : super(key: key);
  void alert() {
    _HardGameScreenState().sureDoldu();
  }

  void yenile() {
    _HardGameScreenState().initState();
  }

  @override
  State<HardGameScreen> createState() => _HardGameScreenState();
}

class _HardGameScreenState extends State<HardGameScreen> {
  void sureDoldu() {
    //print('süre doldu');
  }
  late int _random;
  late BannerAd _bannerAd;
  late BannerAd _bannerAd2;

  bool _isLoaded = true;

  _bannerCek2() {
    _bannerAd2 = BannerAd(
      size: AdSize.banner,
      adUnitId: GameScreenConstants.adUnitId2,
      listener: BannerAdListener(
          onAdLoaded: (ad) {
            setState(() {
              _isLoaded = true;
            });
          },
          onAdFailedToLoad: (ad, error) {}),
      request: const AdRequest(),
    );
    _bannerAd2.load();
  }

  _bannerCek() {
    _bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: GameScreenConstants.adUnitId,
      listener: BannerAdListener(
          onAdLoaded: (ad) {
            setState(() {
              _isLoaded = true;
            });
          },
          onAdFailedToLoad: (ad, error) {}),
      request: const AdRequest(),
    );
    _bannerAd.load();
  }

  @override
  void initState() {
    super.initState();
    _bannerCek();
    _tekrarYap();
    _bannerCek2();
  }

  void disponse() {
    _bannerAd.dispose();
    _bannerAd2.dispose();
    super.dispose();
  }

  Widget _reklamGetir() => SizedBox(
        child: _isLoaded
            ? SizedBox(
                height: _bannerAd.size.height.toDouble(),
                width: _bannerAd.size.width.toDouble(),
                child: AdWidget(
                  ad: _bannerAd,
                ),
              )
            : const SizedBox(),
      );
  Widget _reklamGetir2() => SizedBox(
        child: _isLoaded
            ? SizedBox(
                height: _bannerAd2.size.height.toDouble(),
                width: _bannerAd2.size.width.toDouble(),
                child: AdWidget(
                  ad: _bannerAd2,
                ),
              )
            : const SizedBox(),
      );

  void _tekrarYap() {
    setState(() {
      _random = Random().nextInt(20);
      _veriCek();
      _listeOlustur();
    });
  }

  void _veriCek() {
    GameScreenConstants.a = HardGameInventory().listele();

    GameScreenConstants.question1 =
        GameScreenConstants.a[_random][0].toString();
    GameScreenConstants.question2 =
        GameScreenConstants.a[_random][1].toString();

    GameScreenConstants.reply = GameScreenConstants.a[_random][2].toString();

    GameScreenConstants.fakeReply1 =
        GameScreenConstants.a[_random][3].toString();
    GameScreenConstants.fakeReply2 =
        GameScreenConstants.a[_random][4].toString();
    GameScreenConstants.fakeReply3 =
        GameScreenConstants.a[_random][5].toString();
    GameScreenConstants.fakeReply4 =
        GameScreenConstants.a[_random][6].toString();
    GameScreenConstants.fakeReply5 =
        GameScreenConstants.a[_random][7].toString();
  }

  void _listeOlustur() {
    GameScreenConstants.gonder.clear();
    GameScreenConstants.gonder.addAll({
      [GameScreenConstants.reply, true],
      [GameScreenConstants.fakeReply1, false],
      [GameScreenConstants.fakeReply2, false],
      [GameScreenConstants.fakeReply3, false],
      [GameScreenConstants.fakeReply4, false],
      [GameScreenConstants.fakeReply5, false],
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
              Padding(
                child: _reklamGetir(),
                padding: const EdgeInsets.symmetric(vertical: 20),
              ),
              _ColumnWidgets(
                kontrol1: GameScreenConstants.gonder[0][1],
                kontrol2: GameScreenConstants.gonder[1][1],
                replyText1: GameScreenConstants.gonder[0][0],
                replyText2: GameScreenConstants.gonder[1][0],
              ),
              _ColumnWidgets(
                kontrol1: GameScreenConstants.gonder[2][1],
                kontrol2: GameScreenConstants.gonder[3][1],
                replyText1: GameScreenConstants.gonder[2][0],
                replyText2: GameScreenConstants.gonder[3][0],
              ),
              _ColumnWidgets(
                kontrol1: GameScreenConstants.gonder[4][1],
                kontrol2: GameScreenConstants.gonder[5][1],
                replyText1: GameScreenConstants.gonder[4][0],
                replyText2: GameScreenConstants.gonder[5][0],
              ),
              Padding(
                child: _reklamGetir2(),
                padding: const EdgeInsets.symmetric(vertical: 20),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class _ColumnWidgets extends StatelessWidget {
  final String replyText1;
  final String replyText2;
  final bool kontrol1;
  final bool kontrol2;
  const _ColumnWidgets({
    Key? key,
    required this.replyText1,
    required this.replyText2,
    required this.kontrol1,
    required this.kontrol2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ReplyContainer(
                replyText: replyText1,
                screenName: GameScreenConstants.hardGameScreenName,
                kontrol: kontrol1,
              ),
              ReplyContainer(
                replyText: replyText2,
                screenName: GameScreenConstants.hardGameScreenName,
                kontrol: kontrol2,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
