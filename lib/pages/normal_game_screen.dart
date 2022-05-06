import 'dart:math';
import 'package:carpimskoroyunu/core/core_widgets.dart';
import 'package:carpimskoroyunu/utils/normal_game_inventory.dart';
import 'package:flutter/material.dart';

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

class _NormalGameScreenState extends State<NormalGameScreen>
    with _GameScreenConstants {
  void sureDoldu() {
    //print('süre doldu');
  }

  @override
  void initState() {
    super.initState();
    _tekrarYap();
  }

  void _tekrarYap() {
    setState(() {
      _randomIndex = Random().nextInt(20);
      _veriCek();
      _listeOlustur();
    });
  }

  void _veriCek() {
    try {
      _a = NormalGameInventory().listele();

      _question1 = _a[_randomIndex][0].toString();
      _question2 = _a[_randomIndex][1].toString();
      _reply = _a[_randomIndex][2].toString();
      _fakeReply1 = _a[_randomIndex][3].toString();
      _fakeReply2 = _a[_randomIndex][4].toString();
      _fakeReply3 = _a[_randomIndex][5].toString();
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  void _listeOlustur() {
    _gonder.clear();
    _gonder.addAll({
      [_reply, true],
      [_fakeReply1, false],
      [_fakeReply2, false],
      [_fakeReply3, false],
    });
    _gonder.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SureHesaplayici(
          sure: _geriSayimSuresi,
          screenIndexCount: _screenIndexCount,
        ),
        centerTitle: true,
        leading: const TurnBackButton(),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              QuestionTextWidget(
                question1: _question1,
                question2: _question2,
              ),
              const Spacer(),
              _ColumnWidgets(
                backColor: _backColor,
                kontrol1: _gonder[0][1],
                kontrol2: _gonder[1][1],
                screenIndexCount: _screenIndexCount,
                replyText1: _gonder[0][0],
                replyText2: _gonder[1][0],
              ),
              _ColumnWidgets(
                backColor: _backColor,
                kontrol1: _gonder[2][1],
                kontrol2: _gonder[3][1],
                screenIndexCount: _screenIndexCount,
                replyText1: _gonder[2][0],
                replyText2: _gonder[3][0],
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
  final int screenIndexCount;
  final Color backColor;
  final bool kontrol1;
  final bool kontrol2;
  const _ColumnWidgets({
    Key? key,
    required this.replyText1,
    required this.replyText2,
    required this.backColor,
    required this.kontrol1,
    required this.kontrol2,
    required this.screenIndexCount,
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
                backColor: backColor,
                screenIndexCount: screenIndexCount,
                kontrol: kontrol1,
              ),
              ReplyContainer(
                replyText: replyText2,
                backColor: backColor,
                screenIndexCount: screenIndexCount,
                kontrol: kontrol2,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GameScreenConstants {
  List _a = [];

  late String _question1 = '';

  late String _question2 = '';

  late String _reply = '';

  final int _geriSayimSuresi = 8;

  late String _fakeReply1 = '';

  late String _fakeReply2 = '';

  late String _fakeReply3 = '';

  late final List _gonder = [];

  late int _randomIndex = Random().nextInt(20);

  // ignore: prefer_final_fields
  late Color _backColor = Colors.transparent;

  final int _screenIndexCount = 1;
}
