import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class ShareWidgetUtils {
  ScreenshotController screenshotController;

  ShareWidgetUtils({required this.screenshotController});

  takeImageAndShare() async {
    await screenshotController
        .capture(delay: const Duration(milliseconds: 10))
        .then((image) async {
      if (image != null) {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath = await File('${directory.path}/scor.png').create();
        await imagePath.writeAsBytes(image);
        String appUrl =
            'https://play.google.com/store/apps/details?id=com.ekabav.carpimskoroyunu';

        /// Share Plugin
        await Share.shareFiles(
          [imagePath.path],
          text: 'Bak bu benim skorum sen de denemelisin!'
              '\n $appUrl',
        );
      }
    });
  }
}
