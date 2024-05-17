import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:locator/models/firebase.dart';
import 'package:super_cupertino_navigation_bar/utils/transitionable_navigation_bar.dart';

void downloadInfo() async {
    FirebaseDatabase databaseRef = FirebaseDatabase.instance;
    final ref = databaseRef.ref();
    await ref.child('objects').get().then((DataSnapshot snapshot) {
     List<Object?> valuesList = snapshot.value as List<Object?>;
      Map<dynamic, dynamic> valuesMap = Map.fromIterable(valuesList,
      key: (item) => valuesList.indexOf(item),
      value: (item) => item,);
      Map<String,dynamic> normalMap = {
        'category': valuesMap[0]['category'],
        'coordinates': valuesMap[0]['coordinates'],
        'desc': valuesMap[0]['desc'],
        'id': valuesMap[0]['id'],
        'image': valuesMap[0]['image'],
        'name': valuesMap[0]['name']};

        debugPrint(normalMap.toString());
        CustomData customData = CustomData.fromMap(normalMap);
        debugPrint(customData.category);
        debugPrint(customData.coordinates);
    }).catchError((error) {
      print('Error reading data: $error');
    });
  }