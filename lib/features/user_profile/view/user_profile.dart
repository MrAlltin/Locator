import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:locator/repositories/firebase.dart';
import 'package:locator/themes/main_theme/export.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _currentPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    String displayName = _auth.currentUser!.displayName.toString();
    final String email = _auth.currentUser!.email.toString();
    TextEditingController _displayNameController;
    if (displayName == 'null') {
      _displayNameController = TextEditingController();
    } else {
      _displayNameController = TextEditingController(text: displayName);
    }
    final TextEditingController _emailController =
        TextEditingController(text: email);

    Divider divider = const Divider();

    return CupertinoTabView(
      builder: (context) {
        return Container(
            color: appBarColor,
            child: Container(
                margin: const EdgeInsets.only(top: 12),
                child: SingleChildScrollView(
                  child: CupertinoPageScaffold(
                      navigationBar: CupertinoNavigationBar(
                        border: null,
                        leading: CupertinoNavigationBarBackButton(
                          previousPageTitle: 'Настройки',
                          onPressed: () {
                            Navigator.of(
                              context,
                              rootNavigator: true,
                            ).pop(
                              context,
                            );
                          },
                        ),
                        middle: const Text('Мой профиль'),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          const Align(
                            alignment: Alignment.center,
                            child: Text('Информация об аккаунте'),
                          ),
                          Card(
                              margin: const EdgeInsets.only(
                                  bottom: 15, left: 15, right: 15),
                              color: mainCard,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 15, bottom: 15, left: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  textDirection: TextDirection.ltr,
                                  children: [
                                    Text(
                                      'Никнейм:',
                                      style: mainTheme.textTheme.labelSmall,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 15),
                                      child: CupertinoTextField(
                                        controller: _displayNameController,
                                        placeholder: 'Введите никнейм',
                                        keyboardType: TextInputType.text,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    divider,
                                    Text(
                                      'Эл. почта:',
                                      style: mainTheme.textTheme.labelSmall,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 15),
                                      child: CupertinoTextField(
                                        controller: _emailController,
                                        keyboardType: TextInputType.text,
                                        readOnly: true,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: CupertinoButton.filled(
                                        onPressed: () {
                                          updateDisplayName(
                                              _displayNameController.text);
                                        },
                                        child: const Text('Сохранить'),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          const SizedBox(
                            height: 7,
                          ),
                          const Align(
                            alignment: Alignment.center,
                            child: Text('Изменение пароля'),
                          ),
                          Card(
                              margin: const EdgeInsets.only(
                                  left: 15, right: 15, bottom: 15),
                              color: mainCard,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 15, bottom: 15, left: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  textDirection: TextDirection.ltr,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 15),
                                      child: CupertinoTextField(
                                        controller: _currentPasswordController,
                                        placeholder: 'Введите старый пароль',
                                        obscureText: true,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    divider,
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 15),
                                      child: CupertinoTextField(
                                        controller: _passwordController,
                                        placeholder: 'Введите новый пароль',
                                        obscureText: true,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    divider,
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    // Text(
                                    //   'Эл. почта:',
                                    //   style: mainTheme.textTheme.labelSmall,
                                    // ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 15),
                                      child: CupertinoTextField(
                                        controller: _confirmPasswordController,
                                        placeholder: 'Повторите новый пароль',
                                        obscureText: true,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: CupertinoButton.filled(
                                        onPressed: () {
                                          changeUserPassword();
                                        },
                                        child: const Text('Изменить'),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          Align(
                            alignment: Alignment.center,
                            child: CupertinoButton.filled(
                              onPressed: () {
                                downloadInfo();
                              },
                              child: const Text('Cчитать данные'),
                            ),
                          ),
                        ],
                      )),
                )));
      },
    );
  }



  Future<void> changeUserPassword() async {
    if (_currentPasswordController.text == _passwordController.text) {
      ErrorDialog('Старый и новый пароли должны отличаться');
    } else if (_passwordController.text != _confirmPasswordController.text) {
      ErrorDialog('Пароли должны совпадать');
    } else {
      try {
        await _auth.currentUser
            ?.reauthenticateWithCredential(EmailAuthProvider.credential(
          email: _auth.currentUser!.email.toString(),
          password: _currentPasswordController.text,
        ));
        await _auth.currentUser!.updatePassword(_passwordController.text);
        SuccessDialog('Пароль изменен');
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case 'weak-password':
            ErrorDialog('Слишком простой пароль');
            break;
          case 'invalid-credential':
            ErrorDialog('Указан неверный пароль');
        }
        ErrorDialog('Не удалось изменить пароль \n ${e.code}');
        debugPrint('Exception: $e, \n with e.code: ${e.code}');
      }
    }
  }

  void updateDisplayName(String displayName) {
    try {
      _auth.currentUser!.updateDisplayName(displayName);
      SuccessDialog('Имя пользователя изменено');
    } on FirebaseAuthException catch (e) {
      ErrorDialog('Не удалось изменить имя пользователя \n ${e.code}');
      debugPrint(e.toString());
    }
  }

  Future<dynamic> SuccessDialog(String message) {
    return showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text('Успех!'),
            content: Text(message),
            actions: [
              CupertinoDialogAction(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }

  Future<dynamic> ErrorDialog(String error) {
    return showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text('Ошибка'),
            content: Text(error),
            actions: [
              CupertinoDialogAction(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }
}

