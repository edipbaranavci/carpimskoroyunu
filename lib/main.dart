import 'package:carpimskoroyunu/models/get_datas.dart';
import 'package:carpimskoroyunu/pages/first_login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'pages/login_page.dart';

_widgetKontrol() async {
  if (Datas().widgetKontrol() == true) {
    firstScreen = InventoryScreen();
  } else {
    firstScreen = const FirstLoginScreen();
  }
}

Future<void> main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  await _widgetKontrol();
  runApp(const MyApp());
}

late Widget firstScreen = const SizedBox();

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Çarpım Skor Oyunu',
      theme: ThemeData(
        primaryColor: Colors.amber,
        fontFamily: 'RussoOne',
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(color: Colors.black),
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.amber),
          backgroundColor: Colors.transparent,
        ),
        primarySwatch: Colors.blue,
      ),
      home: firstScreen,
    );
  }
}
