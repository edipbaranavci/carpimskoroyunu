import 'package:carpimskoroyunu/constants.dart';
import 'package:carpimskoroyunu/pages/easy_game_page.dart';
import 'package:carpimskoroyunu/pages/hard_game_page.dart';
import 'package:carpimskoroyunu/pages/normal_game_page.dart';
import 'package:carpimskoroyunu/pages/scors_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class InventoryScreen extends StatefulWidget with _InventoryScreenConstants {
  InventoryScreen({Key? key}) : super(key: key);

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
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
    return Scaffold(
      bottomNavigationBar: SizedBox(child: _reklamGetir2()),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                widget._title,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    ?.copyWith(color: Theme.of(context).bottomAppBarColor),
              ),
            ),
            _InventoryButtons(
              function: () => Get.to(() => const EasyGameScreen(),
                  transition: Transition.rightToLeft),
              buttonTitle: widget._kolay,
            ),
            _InventoryButtons(
              function: () => Get.to(() => const NormalGameScreen(),
                  transition: Transition.rightToLeft),
              buttonTitle: widget._normal,
            ),
            _InventoryButtons(
              function: () => Get.to(() => const HardGameScreen(),
                  transition: Transition.rightToLeft),
              buttonTitle: widget._zor,
            ),
            _InventoryButtons(
              function: () => Get.to(() => ScorsScreen(),
                  transition: Transition.rightToLeft),
              buttonTitle: widget._skorum,
            ),
            SizedBox(child: _reklamGetir()),
          ],
        ),
      ),
    );
  }
}

class _InventoryButtons extends StatelessWidget {
  final String buttonTitle;
  final void Function()? function;
  const _InventoryButtons({
    Key? key,
    required this.buttonTitle,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ButtonStyle customElevatedButtonStyle = ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 10),
      primary: Theme.of(context).primaryColor,
    );

    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.7,
      child: ElevatedButton(
        style: customElevatedButtonStyle,
        onPressed: function,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                buttonTitle,
                style: Theme.of(context).textTheme.headline4?.copyWith(
                      color: Theme.of(context).bottomAppBarColor,
                    ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Theme.of(context).bottomAppBarColor,
            )
          ],
        ),
      ),
    );
  }
}

class _InventoryScreenConstants {
  final String _kolay = 'Kolay';
  final String _normal = 'Normal';
  final String _zor = 'Zor';
  final String _skorum = 'Skorlarım';
  final String _title = 'Oynamak İstedin Zorluğu Seç:\nKolay, Normal, Zor';
}
