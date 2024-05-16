import 'package:flutter/cupertino.dart';
import 'package:locator/features/location_list/view/view.dart';
import 'themes/main_theme/export.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:locator/features/user_profile/view/view.dart';

class CupertinoLocationApp extends StatelessWidget {
  const CupertinoLocationApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(appBarColor); // Установите желаемый 
    return  CupertinoApp(
      title: 'Flutter Demo',
      routes: {
        '/': (context) => CupertinoLocationList(name: 'Куда, Питер?'),
        '/user-profile': (context) => UserProfile(),
      },
      theme: cupertinoTheme,
      // home: CupertinoLocationList(name: 'Куда, Питер?'),
    );
  }

}