import 'package:flutter/cupertino.dart';
import 'package:locator/features/location_list/view/view.dart';
import 'themes/main_theme/export.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';

class CupertinoLocationApp extends StatelessWidget {
  const CupertinoLocationApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(appBarColor); // Установите желаемый цвет StatusBar здесь
    return CupertinoApp(
      title: 'Flutter Demo',
      theme: cupertinoTheme,
      home: const CupertinoLocationList(name: 'Куда, Питер?'),
    );
  }

}