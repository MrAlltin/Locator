import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenYandexMaps {
  createRoute(String coordinates, String name) async {
    if (Platform.isAndroid) {
      List<String> splitted = coordinates.split(',');
      String first = splitted[0];
      String second = splitted[1];
      String url = 'yandexmaps://maps.yandex.ru/?rtext=~$first,$second';
      await launchUrl(Uri.parse(url));
    }
    debugPrint('Pressed: "Маршрут" in ${name}');
  }
}
