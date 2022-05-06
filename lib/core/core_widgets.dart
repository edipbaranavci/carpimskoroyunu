import 'dart:async';
import 'package:carpimskoroyunu/constants.dart';
import 'package:carpimskoroyunu/models/hive_datas.dart';
import 'package:carpimskoroyunu/pages/inventory_screen.dart';
import 'package:carpimskoroyunu/utils/game_screens_updates.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slide_countdown/slide_countdown.dart';
import '../pages/false_reply_screen.dart';

// ignore: must_be_immutable
class ReplyContainer extends StatefulWidget {
  final String replyText;
  final int screenIndexCount;
  late Color backColor;
  final bool kontrol;

  ReplyContainer({
    Key? key,
    required this.screenIndexCount,
    required this.replyText,
    this.backColor = Colors.transparent,
    required this.kontrol,
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
      GameScreensUpdates(widget.screenIndexCount).widgetUpdate();
    });
  }

  _falseReply() async {
    setState(() {
      widget.backColor = Colors.red;
    });

    late SkorDatas _skorDatas;
    late String _mod;
    Future<int> oku(int index) async {
      late int skorumuz;
      _skorDatas = await HiveDatas().oku();
      if (index == 0) {
        skorumuz = _skorDatas.mod0;
        _mod = 'Kolay';
      } else if (index == 1) {
        skorumuz = _skorDatas.mod1;
        _mod = 'Normal';
      } else {
        skorumuz = _skorDatas.mod2;
        _mod = 'Zor';
      }
      //print(skorumuz);
      //await Future.delayed(const Duration(milliseconds: 50), () async {});
      return skorumuz;
    }

    await Future.delayed(const Duration(milliseconds: 350), () async {
      int _skor = await oku(widget.screenIndexCount);
      showDialog(
        context: context,
        builder: (BuildContext context) =>
            FalseReplyScreenDialog().falseReply(_skor.toInt(), _mod),
      );
    });
  }

  _replyController() {
    if (widget.kontrol == true) {
      _trueReply();
      _yazdir();
    } else
      // ignore: curly_braces_in_flow_control_structures
      _falseReply();
  }

  _yazdir() {
    int yazilacakDeger = widget.screenIndexCount + 1;
    HiveDatas().guncelle(widget.screenIndexCount, yazilacakDeger);
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

class SureHesaplayici extends StatefulWidget {
  final int sure;
  final int screenIndexCount;
  const SureHesaplayici({
    Key? key,
    required this.sure,
    required this.screenIndexCount,
  }) : super(key: key);
  @override
  State<SureHesaplayici> createState() => _SureHesaplayiciState();
}

class _SureHesaplayiciState extends State<SureHesaplayici> {
  late int kalanSure = widget.sure;

  _sureBitti() {
    //print('Süre Bitti');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SlideCountdownSeparated(
        onDone: _sureBitti,
        duration: Duration(seconds: kalanSure),
        textStyle: TextStyle(color: Theme.of(context).bottomAppBarColor),
        decoration: const BoxDecoration(
          color: Colors.green,
        ),
      ),
    );
  }
}

class TurnBackButton extends StatelessWidget {
  const TurnBackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Get.offAll(
          () => const InventoryScreen(),
          transition: Transition.leftToRight,
        );
      },
      icon: const Icon(
        Icons.chevron_left,
      ),
    );
  }
}
