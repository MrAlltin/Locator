import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:locator/features/profile_app_screen/view/user_page.dart';
import 'package:locator/features/profile_app_screen/widgets/widgets.dart';
import 'package:locator/themes/main_theme/export.dart';

import '../../user_profile/view/view.dart';

class UserPageBody extends StatefulWidget {
  const UserPageBody({super.key});

  @override
  State<UserPageBody> createState() => _UserPageBodyState();
}

class _UserPageBodyState extends State<UserPageBody> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> signOut() async {
    await _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    Icon chevron = const Icon(CupertinoIcons.chevron_forward);
    return SafeArea(
        child: Column(children: [
      (_auth.currentUser!.displayName != null)
          ? Text(_auth.currentUser!.displayName.toString())
          : Text(_auth.currentUser!.email.toString()),
      Card(
        color: mainCard,
        margin: const EdgeInsets.all(15),
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            CupertinoListTile(
              leading: const Icon(
                CupertinoIcons.person_alt_circle,
                size: 30,
              ),
              title: const Text('Мой профиль'),
              trailing: chevron,
              onTap: () {
                Navigator.pushNamed(context, '/user-profile');
                // Navigator.of(context, rootNavigator: true).push(
                //   CupertinoPageRoute(builder: (context) => UserProfile()),
                // );
              },
            ),
            const Divider(),
            CupertinoListTile(
              leading: const Icon(
                CupertinoIcons.settings,
                size: 30,
              ),
              title: const Text('Настройки'),
              trailing: chevron,
              onTap: () {
                debugPrint('ListTile нажат!');
              },
            ),
            const Divider(),
            CupertinoListTile(
              leading: const Icon(
                CupertinoIcons.info,
                size: 30,
              ),
              title: const Text('О приложении'),
              trailing: chevron,
              onTap: () {
                debugPrint('ListTile нажат!');
              },
            ),
            const Divider(),
            CupertinoListTile(
              leading: const Icon(
                CupertinoIcons.bubble_left_bubble_right,
                size: 30,
              ),
              title: const Text('Связаться с нами'),
              trailing: chevron,
              onTap: () {
                debugPrint('ListTile нажат!');
              },
            ),
            Padding(padding: EdgeInsets.only(bottom: 5)),
          ],
        ),
      ),
      // CupertinoButton(
      //   child: const Text('Изменить DisplayName'),
      //   onPressed: () {
      //     _auth.currentUser!.updateDisplayName('MrAlltin');
      //   },
      // ),
      CupertinoButton(
        child: const Text('Выйти'),
        onPressed: () {
          signOut();
          profileUpdateNotifier.notifyProfileUpdate();
        },
      )
    ]));
  }

  FutureOr<void> newMethod() {
    debugPrint('ListTile нажат!');
  }
}
