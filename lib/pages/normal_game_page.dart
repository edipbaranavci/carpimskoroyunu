import 'dart:math';
import 'package:carpimskoroyunu/constants.dart';
import 'package:carpimskoroyunu/core/core_widgets.dart';
import 'package:carpimskoroyunu/utils/normal_game_inventory.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class NormalGameScreen extends StatefulWidget {
  const NormalGameScreen({Key? key}) : super(key: key);

  void alert() {
    _NormalGameScreenState().sureDoldu();
  }

  void yenile() {
    _NormalGameScreenState().initState();
  }

  @override
  State<NormalGameScreen> createState() => _NormalGameScreenState();
}

class _NormalGameScreenState extends State<NormalGameScreen> {
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

  void _tekrarYap() {
    setState(() {
      _random = Random().nextInt(20);
      _veriCek();
      _listeOlustur();
    });
  }

  void _veriCek() {
    try {
      GameScreenConstants.a = NormalGameInventory().listele();

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
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  void _listeOlustur() {
    GameScreenConstants.gonder.clear();
    GameScreenConstants.gonder.addAll({
      [GameScreenConstants.reply, true],
      [GameScreenConstants.fakeReply1, false],
      [GameScreenConstants.fakeReply2, false],
      [GameScreenConstants.fakeReply3, false],
    });
    GameScreenConstants.gonder.shuffle();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CountDownWidget(sure: GameScreenConstants.gameScreenCountDown),
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
                screenName: GameScreenConstants.normalGameScreenName,
                kontrol: kontrol1,
              ),
              ReplyContainer(
                replyText: replyText2,
                screenName: GameScreenConstants.normalGameScreenName,
                kontrol: kontrol2,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
