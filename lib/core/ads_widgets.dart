import 'package:carpimskoroyunu/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsWidgets extends StatefulWidget {
  final bool adsWidgetTwo;
  const AdsWidgets({Key? key, required this.adsWidgetTwo}) : super(key: key);

  @override
  State<AdsWidgets> createState() => _AdsWidgetsState();
}

class _AdsWidgetsState extends State<AdsWidgets> {
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
    _bannerCek2();
  }

  void disponse() {
    _bannerAd.dispose();
    _bannerAd2.dispose();
    _isLoaded = false;
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      child: widget.adsWidgetTwo ? _reklamGetir() : _reklamGetir2(),
      padding: const EdgeInsets.symmetric(vertical: 20),
    );
  }
}
