import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:locator/features/profile_app_screen/widgets/widgets.dart';
import 'package:locator/themes/main_theme/export.dart';

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
    const Divider divider = Divider(
      indent: 65,
    );
    String helloText = (_auth.currentUser!.displayName != null)
        ? '${_auth.currentUser!.displayName.toString()}, для вас:'
        : _auth.currentUser!.email.toString();
    String avatarLetter = helloText.substring(0, 1).toUpperCase();

    return SafeArea(
        child: Column(children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 15,
          ),
          Text(helloText),
        ],
      ),

      Card(
        color: mainCard,
        margin: const EdgeInsets.all(15),
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            CupertinoListTile(
              leading: CircleAvatar(
                backgroundColor:
                    cupertinoTheme.primaryColor, // Цвет фона круглого элемента
                radius: 30, // Радиус круглого элемента
                child: Text(
                  avatarLetter, // Буква или текст, который вы хотите отобразить
                  style: const TextStyle(
                    color: Colors.white, // Цвет текста
                    fontSize: 20, // Размер текста
                  ),
                ),
              ),
              title: const Text('Мой профиль'),
              trailing: chevron,
              onTap: () {
                Navigator.pushNamed(context, '/user-profile');
              },
            ),
            // CupertinoListTile(
            //   leading: const Icon(
            //     CupertinoIcons.person_alt_circle,
            //     size: 30,
            //   ),
            //   title: const Text('Мой профиль'),
            //   trailing: chevron,
            //   onTap: () {
            //     Navigator.pushNamed(context, '/user-profile');
            //   },
            // ),
            divider,
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
            divider,
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
            divider,
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
            const Padding(padding: EdgeInsets.only(bottom: 5)),
          ],
        ),
      ),
      // CupertinoButton(
      //   child: const Text('Изменить DisplayName'),
      // onPressed: () {
      //   _auth.currentUser!.updateDisplayName('MrAlltin');
      // },
      // ),
      CupertinoButton(
        child: const Text('Выйти'),
        onPressed: () {
          signOut();
          profileUpdateNotifier.notifyProfileUpdate(false);
        },
      )
    ]));
  }
}
