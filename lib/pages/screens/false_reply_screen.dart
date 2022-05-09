import 'package:carpimskoroyunu/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class FalseReplyScreenDialog {
  FalseReplyScreenDialog() {
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

  SimpleDialog falseReply(int skor, String mod) {
    return SimpleDialog(
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Yanlış Cevaba Tıkladın!\n $mod Mod Skorun: $skor',
          textAlign: TextAlign.center,
        ),
      ),
      children: [
        Container(
          margin: const EdgeInsets.all(8.0),
          child: MaterialButton(
            padding: const EdgeInsets.all(15),
            color: Colors.deepOrange,
            onPressed: () {
              _adsLoad();
              Get.offAll(() => InventoryScreen());
            },
            child: const Text(
              'Geri Dön',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
        )
      ],
    );
  }
}
