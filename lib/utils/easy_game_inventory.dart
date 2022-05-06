import 'dart:math';

class EasyGameInventory {
  final int _baslangic = 1;
  final int _bitis = 5;

  // ignore: non_constant_identifier_names
  int _RandomIntGenerator(int sonuc) {
    int _value = 1;
    for (int i = 1; i < 100; i--) {
      _value = Random().nextInt(20) + _baslangic;
      if (_value != sonuc) {
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
        _giden.add([i, j, sonuc, _RandomIntGenerator(sonuc)]);
      }
    }
    _giden.shuffle();
    return _giden;
  }
}
