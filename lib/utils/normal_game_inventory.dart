import 'dart:math';

class NormalGameInventory {
  final int _baslangic = 5;
  final int _bitis = 12;

  // ignore: non_constant_identifier_names
  int _RandomIntGenerator(int sonuc) {
    int _value = 1;
    int baslangic = sonuc - 10;
    int bitis = sonuc + 10;
    for (int i = 1; i < 100; i--) {
      _value = Random().nextInt(bitis) + baslangic;
      if (_value != sonuc) {
        break;
      }
    }
    return _value;
  }

  // ignore: non_constant_identifier_names
  int _RandomIntGenerator2(int sonuc, int oldRandom) {
    int _value = 1;
    int baslangic = sonuc - 10;
    int bitis = sonuc + 10;
    for (int i = 1; i < 100; i--) {
      _value = Random().nextInt(bitis) + baslangic;
      if (_value != sonuc && oldRandom != _value) {
        break;
      }
    }
    return _value;
  }

  List listele() {
    List _giden = [];
    //1-5 arasındaki her sayıyı çarptırma
    //1-5 arasındaki her sayıya uygulama
    for (int i = _baslangic; i <= _bitis; i++) {
      for (int j = _baslangic; j <= _bitis; j++) {
        int sonuc = i * j;
        int _random1 = _RandomIntGenerator(sonuc);
        int _random2 = _RandomIntGenerator2(sonuc, _random1);
        int _random3 = _RandomIntGenerator2(sonuc, _random2);
        _giden.add([
          i,
          j,
          sonuc,
          _random1,
          _random2,
          _random3,
        ]);
      }
    }
    _giden.shuffle();
    return _giden;
  }
}
