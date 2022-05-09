import 'package:carpimskoroyunu/constants.dart';
import 'package:carpimskoroyunu/models/skors_datas.dart';
import 'package:get_storage/get_storage.dart';

final GetStorage box = GetStorage();

class Datas {
  final String _giris = 'giris';
  bool widgetKontrol() {
    var _kontrol = box.read(_giris);
    late bool _gonder = false;
    if (_kontrol == 1) {
      _gonder = true;
    } else {
      _gonder = false;
    }
    return _gonder;
  }

  SkorsDatas allDataRead() {
    final SkorsDatas _skorDatas = SkorsDatas(
      easyGameScor: read(GameScreenConstants.easyGameScreenName),
      normalGameScor: read(GameScreenConstants.normalGameScreenName),
      hardGameScor: read(GameScreenConstants.hardGameScreenName),
      totalScor: read(GameScreenConstants.totalGameName),
    );
    return _skorDatas;
  }

  _totalKontrol() {
    if (box.read(GameScreenConstants.totalGameName) == null) {
      box.write(GameScreenConstants.totalGameName, 0);
    }
  }

  firstLogin() {
    box.write(GameScreenConstants.easyGameScreenName, 0);
    box.write(GameScreenConstants.normalGameScreenName, 0);
    box.write(GameScreenConstants.hardGameScreenName, 0);
    box.write(GameScreenConstants.totalGameName, 0);
    box.write(_giris, 1);
  }

  String read(String key) {
    return box.read(key).toString();
  }

  update(String key) {
    int _keyToplam = box.read(key) + 1;
    box.write(key, _keyToplam);
    _totalKontrol();
    int _toplam = box.read(GameScreenConstants.totalGameName) + 1;
    box.write(GameScreenConstants.totalGameName, _toplam);
  }
}
