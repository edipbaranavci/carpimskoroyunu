import 'package:carpimskoroyunu/pages/first_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive_flutter/adapters.dart';
import 'pages/inventory_screen.dart';

_widgetKontrol() async {
  Box _box = await Hive.openBox('Skors');
  if (_box.get(0) != null) {
    firstScreen = const InventoryScreen();
  } else {
    firstScreen = const FirstLoginScreen();
  }
}

Future<void> main() async {
  await Hive.initFlutter();
  var dir = await getApplicationDocumentsDirectory();
  String _dosyaYolu = dir.path + '/EKABAV';
  Hive.init(_dosyaYolu);
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
            iconTheme: IconThemeData(color: Colors.amber),
            backgroundColor: Colors.transparent,
            elevation: 0),
        primarySwatch: Colors.blue,
      ),
      home: firstScreen,
    );
  }
}
