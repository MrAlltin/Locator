import 'package:flutter/material.dart';

final mainTheme = ThemeData(
  primaryColor: Color.fromARGB(100, 50, 50, 50),
  colorScheme:
      ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 77, 180, 80)),
  useMaterial3: true,
  // appBarTheme: const AppBarTheme(
  //   centerTitle: true,
  //   backgroundColor: Color.fromARGB(255, 77, 180, 80),
  // ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    showSelectedLabels: false,
    showUnselectedLabels: false,
    selectedItemColor: Color.fromARGB(100, 50, 50, 50),
    unselectedItemColor: Color.fromARGB(100, 50, 50, 50),
  )
);
