import 'package:carpimskoroyunu/core/core_widgets.dart';
import 'package:carpimskoroyunu/models/get_datas.dart';
import 'package:carpimskoroyunu/models/skors_datas.dart';
import 'package:carpimskoroyunu/pages/screens/skor_screens/easy_scor_screen.dart';
import 'package:carpimskoroyunu/pages/screens/skor_screens/hard_scor_screen.dart';
import 'package:carpimskoroyunu/pages/screens/skor_screens/normal_scor_screen.dart';
import 'package:carpimskoroyunu/pages/screens/skor_screens/total_skor_screen.dart';
import 'package:flutter/material.dart';

class ScorsScreen extends StatelessWidget {
  ScorsScreen({Key? key}) : super(key: key);

  final SkorsDatas _skorsDatas = Datas().allDataRead();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const SkorsPageTitleWidget(),
      ),
      body: PageView(
        physics: const BouncingScrollPhysics(),
        controller: PageController(viewportFraction: 0.95),
        children: [
          EasyGameScorScreen(scor: _skorsDatas.easyGameScor),
          NormalGameScorScreen(scor: _skorsDatas.normalGameScor),
          HardGameScorScreen(scor: _skorsDatas.hardGameScor),
          TotalScorScreen(scor: _skorsDatas.totalScor),
        ],
      ),
    );
  }
}
