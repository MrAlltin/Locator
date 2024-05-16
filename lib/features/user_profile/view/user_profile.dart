import 'package:flutter/cupertino.dart';
import 'package:locator/themes/main_theme/export.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(builder: (context) {
      return Container(color: appBarColor, child:Container(margin: const EdgeInsets.only(top: 12), child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          border: null,
          // padding: EdgeInsetsDirectional.only(top: 30),
          
          leading: CupertinoNavigationBarBackButton(
            previousPageTitle: 'Профиль',
            onPressed: () {
              Navigator.of(
                context,
                rootNavigator: true,
              ).pop(
                context,
              );
            },
          ),
          middle: const Text('Экран1'),
        ),
        child: const Center(
          child: Text('Содержимое вкладки 1'),
        ),
      )));
      
    });
  }
}
