import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:locator/themes/main_theme/export.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

import 'dart:async';

class ProfileUpdateNotifier {
  final StreamController<bool> _profileUpdateController =
      StreamController<bool>.broadcast();

  Stream get profileUpdateStream => _profileUpdateController.stream;

  void notifyProfileUpdate(bool _isAuthenticated) {
    _profileUpdateController.add(_isAuthenticated);
  }

  void dispose() {
    _profileUpdateController.close();
  }
}

final profileUpdateNotifier = ProfileUpdateNotifier();

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isRegistering = false;

  Future<void> _resetPass () async {
    if (_emailController.text.isEmpty){
      return ErrorDialog('Не указана электронная почта');
    }
    try {
      await _auth.sendPasswordResetEmail(email: _emailController.text);
      SuccessDialog('Ссылка для востановления пароля отправлена на электронную почту');
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _authenticate() async {
    String error =
        'Произошла непредвиденая ошибка. \nСвяжитесь с администратором.';
    if (_isRegistering) {
      if (_passwordController.text != _confirmPasswordController.text) {
        ErrorDialog('Пароли должны совпадать');
      }
      try {
        await _auth.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        profileUpdateNotifier.notifyProfileUpdate(true);
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case 'email-already-in-use':
            error = 'Указанная электронная почта уже используется';
            break;
          case 'admin-restricted-operation':
            error =
                'Операция запрещена. \nАдминистратор запретил регистрацию новых участников.';
            break;
          case 'invalid-email':
            error = 'Неверный формат электронной почты';
            break;
        }
        print(e.code);
        ErrorDialog(error);
      }
    } else {
      try {
        await _auth.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        profileUpdateNotifier.notifyProfileUpdate(true);
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case 'invalid-email':
            error = 'Неверный формат электронной почты';
            break;
          case 'user-not-found':
            error = 'Пользователь с указанным email не найден';
            break;
          case 'wrong-password':
            error = 'Введен неверный пароль';
            break;
          case 'user-disabled':
            error = 'Пользователь заблокирован';
            break;
          case 'invalid-credential':
            error = 'Неверные учетные данные';
            break;
        }
        if (_passwordController.text.isEmpty || _emailController.text.isEmpty){
          error = 'Поля обязательны для заполнения';
        }
        ErrorDialog(error);
      }
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: SuperScaffold(
      appBar: SuperAppBar(
          largeTitle: SuperLargeTitle(enabled: false),
          title: const Text('Профиль'),
          searchBar: SuperSearchBar(enabled: false)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(children: [
                Expanded(
                  child: CupertinoSegmentedControl(
                    children: const {
                      0: Text('Войти'),
                      1: Text('Регистрация'),
                    },
                    onValueChanged: (int newValue) {
                      setState(() {
                        _isRegistering = newValue == 1;
                      });
                    },
                    groupValue: _isRegistering ? 1 : 0,
                  ),
                )
              ]),
              const SizedBox(height: 16.0),
              CupertinoTextField(
                controller: _emailController,
                placeholder: 'Электронная почта',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16.0),
              CupertinoTextField(
                controller: _passwordController,
                placeholder: 'Пароль',
                obscureText: true,
              ),
              if (!_isRegistering)
                Column(
                  children: [
                    const SizedBox(height: 16.0),
                    TextButton(
                      style: mainTheme.textButtonTheme.style,
                      child: const Text('Забыли пароль?'),
                      onPressed: () {
                        _resetPass();
                      },
                    )
                  ],
                ),
              if (_isRegistering)
                Column(
                  children: [
                    const SizedBox(height: 16.0),
                    CupertinoTextField(
                      controller: _confirmPasswordController,
                      placeholder: 'Повторите пароль',
                      obscureText: true,
                    ),
                  ],
                ),
              const SizedBox(height: 16.0),
              CupertinoButton.filled(
                onPressed: _authenticate,
                child: Text(_isRegistering ? 'Зарегистрироваться' : 'Войти'),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}


