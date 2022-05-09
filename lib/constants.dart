import 'dart:math';

import 'package:flutter/material.dart';

class GameScreenConstants {
  static const EdgeInsets replyMargin = EdgeInsets.symmetric(horizontal: 10);
  static const EdgeInsets replyPadding = EdgeInsets.symmetric(horizontal: 10);

  static late int randomIndex = Random().nextInt(20);

//ints
  static int gameScreenCountDown = 8;

  static late List a = [];
  static late final List gonder = [];

//Strings
  //static const String adUnitId = "ca-app-pub-7487352118674207/2514174006";
  //static const String adUnitId2 = "ca-app-pub-7487352118674207/8546311458";
  static const String adUnitId = "";
  static const String adUnitId2 = "";

  static late String question1 = '';
  static late String question2 = '';

  static late String reply = '';
  static late String fakeReply1 = '';
  static late String fakeReply2 = '';
  static late String fakeReply3 = '';
  static late String fakeReply4 = '';
  static late String fakeReply5 = '';

  static const String easyGameScreenName = 'easy';
  static const String normalGameScreenName = 'normal';
  static const String hardGameScreenName = 'hard';
  static const String totalGameName = 'total';

  static late Color backColor = Colors.transparent;
}

class FirstLoginScreenStrings {
  static const String title = 'Çarpma Skor Oyununa Hoşgeldin!';
  static const String description =
      'Çarpma Sorularını çözerek puan toplayıp skorunu yükselt!';
  static const String buttonTitle = 'Çözmeye Başla!';
}

class SkorScreensConstants {
  static const String easyModTitle = 'Kolay Mod Skorum';
  static const String normalModTitle = 'Normal Mod Skorum';
  static const String hardModTitle = 'Zor Mod Skorum';
  static const String totalScorTitle = 'Toplam Oyun Skorum';
  static const String sharedButtonTitle = 'Skorunu Paylaş';
  static const String appBarTitle = 'Skorlarım';

  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(vertical: 10.0);
  static const EdgeInsets buttonTitleLeftPadding = EdgeInsets.only(left: 10.0);
  static const EdgeInsets buttonContentPadding = EdgeInsets.all(10.0);
}
