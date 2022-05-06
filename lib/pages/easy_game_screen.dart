// ignore_for_file: unrelated_type_equality_checks

import 'dart:math';
import 'package:carpimskoroyunu/core/core_widgets.dart';
import 'package:carpimskoroyunu/utils/easy_game_inventory.dart';
import 'package:flutter/material.dart';

class EasyGameScreen extends StatefulWidget {
  const EasyGameScreen({Key? key}) : super(key: key);

  void alert() {}

  void yenile() {
    _EasyGameScreenState()._tekrarYap();
  }

  @override
  State<EasyGameScreen> createState() => _EasyGameScreenState();
}

class _EasyGameScreenState extends State<EasyGameScreen>
    with _GameScreenConstants {
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
      _a = EasyGameInventory().listele();

      _question1 = _a[_randomIndex][0].toString();
      _question2 = _a[_randomIndex][1].toString();
      _reply = _a[_randomIndex][2].toString();
      _fakeReply = _a[_randomIndex][3].toString();
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  void _listeOlustur() {
    _gonder.clear();
    _gonder.addAll({
      [_reply, true],
      [_fakeReply, false]
    });
    _gonder.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SureHesaplayici(
          sure: _geriSayimSuresi,
          screenIndexCount: 0,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ReplyContainer(
                    screenIndexCount: 0,
                    backColor: backColor,
                    replyText: _gonder[0][0],
                    kontrol: _gonder[0][1],
                  ),
                  ReplyContainer(
                    screenIndexCount: 0,
                    backColor: backColor,
                    replyText: _gonder[1][0],
                    kontrol: _gonder[1][1],
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
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

  late String _fakeReply = '';

  late final List _gonder = [];

  late int _randomIndex = Random().nextInt(20);

  late Color backColor = Colors.transparent;
}
