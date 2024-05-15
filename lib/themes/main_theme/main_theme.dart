import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

final mainTheme = ThemeData(
    primaryColor: const Color.fromARGB(100, 50, 50, 50),
    colorScheme:
        ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 77, 180, 80)),
    useMaterial3: true,
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: const Color.fromARGB(255, 77, 180, 80)),
          foregroundColor:const Color.fromARGB(255, 77, 180, 80),
          textStyle: const TextStyle(color: Color.fromARGB(255, 77, 180, 80))),
          
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        fontFamily: 'San Francisco',
          color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20),
      bodySmall: TextStyle(fontFamily: 'San Francisco',
          color: Colors.black, fontWeight: FontWeight.w400, fontSize: 18),
    ),
    // appBarTheme: const AppBarTheme(
    //   centerTitle: true,
    //   backgroundColor: Color.fromARGB(255, 77, 180, 80),
    // ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: Color.fromARGB(100, 50, 50, 50),
      unselectedItemColor: Color.fromARGB(100, 50, 50, 50),
    ));

const appBarColor = Color.fromARGB(255, 250, 255, 250);
const mainCard = Color.fromARGB(255, 237, 255, 237);
const childrenCard = Color.fromARGB(255, 226, 255, 226);

const cupertinoTheme = CupertinoThemeData(
  primaryColor: Color.fromARGB(255, 77, 180, 80),
  barBackgroundColor: appBarColor,
  brightness: Brightness.light,

  // a: const BottomNavigationBarThemeData(
  //   showSelectedLabels: false,
  //   showUnselectedLabels: false,
  //   selectedItemColor: Color.fromARGB(100, 50, 50, 50),
  //   unselectedItemColor: Color.fromARGB(100, 50, 50, 50),
  // )
);
