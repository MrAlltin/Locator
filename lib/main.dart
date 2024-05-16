import 'package:firebase_core/firebase_core.dart';
import 'package:locator/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:locator/cupertino_location_app.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,).catchError((e) => print(e));
  runApp(const CupertinoLocationApp());
}



