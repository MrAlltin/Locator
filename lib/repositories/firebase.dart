import 'dart:collection';
import 'dart:html';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:locator/models/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<CustomData>> downloadInfo(int perPage, int currentPage) async {
  var reference;
  if ((perPage * currentPage) == 0) {
    reference = FirebaseDatabase.instance
        .ref()
        .child('objects')
        .orderByKey()
        .startAt((perPage * currentPage).toString())
        .limitToFirst(perPage);
  } else {
    reference = FirebaseDatabase.instance
        .ref()
        .child('objects')
        .orderByKey()
        .startAfter((perPage * currentPage - 1).toString())
        .limitToFirst(perPage);
  }

  DatabaseEvent event = await reference.once();

  List<CustomData> customDataList = [];
  debugPrint('Heeellooo ${event.snapshot.value}');
  List values = event.snapshot.value as List;
  if (values != null) {
    for (var item in values) {
      if (item != null) {
        customDataList.add(CustomData.fromMap(Map<String, dynamic>.from(item)));
      }
    }
    // List<dynamic> values = event.snapshot.value as List;
    // list.forEach((value) {
    //   if (value != null) {
    //     customDataList
    //         .add(CustomData.fromMap(Map<String, dynamic>.from(value)));
    //   }
    // });
  }
  return customDataList;
}

Future<Uint8List?> downloadImage() async {
  try {
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('assets')
        .child('images/luk.jpg')
        .getData();
    Uint8List? data = await storageRef;
  } catch (e) {
    debugPrint(e.toString());
  }
}

// Работает 100%%
// void downloadInfo() async {
//   FirebaseDatabase databaseRef = FirebaseDatabase.instance;
//   final ref = databaseRef.ref();
//   await ref.child('objects').get().then((DataSnapshot snapshot) {
//     List<Object?> valuesList = snapshot.value as List<Object?>;
//     Map<dynamic, dynamic> valuesMap = Map.fromIterable(
//       valuesList,
//       key: (item) => valuesList.indexOf(item),
//       value: (item) => item,
//     );
//     Map<String, dynamic> normalMap = {
//       'category': valuesMap[0]['category'],
//       'coordinates': valuesMap[0]['coordinates'],
//       'desc': valuesMap[0]['desc'],
//       'id': valuesMap[0]['id'],
//       'image': valuesMap[0]['image'],
//       'name': valuesMap[0]['name']
//     };

//     debugPrint(normalMap.toString());
//     CustomData customData = CustomData.fromMap(normalMap);
//     debugPrint(customData.category);
//     debugPrint(customData.coordinates);
//   }).catchError((error) {
//     print('Error reading data: $error');
//   });
// }
var _lastDocument;
Future<QuerySnapshot<Map<String, dynamic>>> getDataRepository() async {
  FirebaseFirestore instance = FirebaseFirestore.instance;
  var collection = instance.collection('Objects');
  var query = collection.limit(2);
  if (_lastDocument != null) {
    query = query.startAfterDocument(_lastDocument);
  }
  var queryGet = await query.get();
  if (queryGet.size != 0) {
    _lastDocument = queryGet.docs[queryGet.size - 1];
  }
  return await query.get();
}

Future<List<dynamic>> getUserFavorite(User _currentUser, FirebaseFirestore instance) async {
  var collection = instance.collection('Users');
  debugPrint(_currentUser.uid);
  var query = collection.doc(_currentUser.uid);
  List<dynamic> list = await query.get().then((value) {
    final data = value.data();
    return data!['favorites'];
  });
  return list;
}

void addToFavorite(User _currentUser, int id) async{
  FirebaseFirestore instance = FirebaseFirestore.instance;
  List<dynamic> favorites = await getUserFavorite(_currentUser, instance);
  debugPrint('Its addToFavorite $favorites');
  if (!favorites.contains(id)){
      favorites.add(id);
      await instance.collection('Users').doc(_currentUser.uid).set({'favorites': favorites});
  }  
}
void removeFromFavorite(User _currentUser, int id) async{
  FirebaseFirestore instance = FirebaseFirestore.instance;
  List<dynamic> favorites = await getUserFavorite(_currentUser, instance);
  if (favorites.contains(id)){
    favorites.remove(id);
    await instance.collection('Users').doc(_currentUser.uid).set({'favorites': favorites});
  }
}
