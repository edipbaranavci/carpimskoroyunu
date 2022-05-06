import 'package:hive_flutter/hive_flutter.dart';

late Box _box;
late int _gidenSkor = 0;

class SkorDatas {
  final int mod0;
  final int mod1;
  final int mod2;

  SkorDatas({required this.mod0, required this.mod1, required this.mod2});
}

class HiveDatas {
  Future<SkorDatas> oku() async {
    _box = await Hive.openBox('Skors');
    var a = _box.toMap();
    var _gonder = SkorDatas(mod0: a[0], mod1: a[1], mod2: a[2]);
    //print(a);
    return _gonder;
  }

  //// ignore: unused_element
  //_oku() async {
  //  _box = await Hive.openBox('Skors');
  //  var a = _box.toMap();
  //  print(a);
  //}

  int skorCagir(int modIndex) {
    getir(modIndex);
    return _gidenSkor;
  }

  getir(int modIndex) async {
    _gidenSkor = await _box.get(modIndex);
    _kutuKapat();
  }

  Future<int> _getir(int modIndex) async {
    int _gonder = await _box.get(modIndex);
    return _gonder;
  }

  _kutuKapat() {
    if (_box.isOpen) {
      _box.close();
    }
  }

  guncelle(int modIndex, int eklenecekDeger) async {
    _box = await Hive.openBox('Skors');
    int _toplamDeger = eklenecekDeger + await _getir(modIndex);
    _box.put(modIndex, _toplamDeger);
  }

  firstLogin() async {
    _box = await Hive.openBox('Skors');
    await _box.put(0, 0);
    await _box.put(1, 0);
    await _box.put(2, 0);
  }
}

class DatasControl {
  static bool cevap = false;
  kontrol() async {
    _box = await Hive.openBox('Skors');
    if (_box.isNotEmpty) {
      cevap = true;
    } else {
      cevap = false;
    }
    //print(cevap);
  }
}
