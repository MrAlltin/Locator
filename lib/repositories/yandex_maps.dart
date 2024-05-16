import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class OpenYandexMaps {
  createRoute(Uri uri) async {
    if (kIsWeb || Platform.isIOS) {
      await launchUrl(uri);
    } else if (Platform.isAndroid) {
      await launchUrl(uri);
    } else if (Platform.isWindows) {
      await launchUrl(uri);
    }
  }
}

CupertinoAlertDialog CupertinoAlert(BuildContext context) {
    return CupertinoAlertDialog(
                            title: const Text('Ошибка'),
                            content: const Text(
                                'Кажется, у вас не установлены Яндекс.Карты\n Они необходимы для построения маршрута'),
                            actions: [
                              CupertinoDialogAction(
                                  child: const Text('Я понял'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  })
                            ]);
  }

