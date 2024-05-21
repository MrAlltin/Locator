import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:locator/models/firebase.dart';
import 'package:locator/models/models.dart';
import 'package:locator/repositories/yandex_maps.dart';
import 'package:locator/themes/main_theme/export.dart';

class LocationCard extends StatefulWidget {
  const LocationCard({
    Key? key,
    required this.location,
  }) : super(key: key);
  final CustomData location;

  @override
  State<LocationCard> createState() => _LocationCardState();
}

class _LocationCardState extends State<LocationCard> {
  final Reference storageRef = FirebaseStorage.instance.ref();
  String? _url;
  Uint8List? _image;
  bool isFavorite = false;
  List<FavoriteItem>? favorites;
  final String key = 'favorites';

  @override
  void initState() {
    super.initState();
    _downloadImage(widget.location.image);
  }

  void _downloadImage(String imageName) async {
    final imagesRef = storageRef.child(imageName);
    imagesRef.getData().then((value){
      setState(() {
        _image = value;
      });
    });
  }

  // void _downloadImageFiles(String imageName) async {
  //   final imagesRef = storageRef.child(imageName);
  //   imagesRef.getDownloadURL().then((value) {
  //     setState(() {
  //       _url = value;
  //     });
  //   });
  // }

  // void loadFavoritesStatus() async {
  //   // favorites = await loadFavorites(key);
  //   debugPrint(favorites.toString());
  //   favorites?.forEach((element) {
  //     if (element.title == widget.location.name) {
  //       setState(() {
  //         isFavorite = true;
  //       });
  //     }
  //   });
  // }

  Icon favoriteIcon = const Icon(Icons.favorite_border);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
      color: mainCard,
      child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
        ListTile(
          // leading: const Icon(Icons.forest),
          leading: const Icon(Icons.forest),
          title: Text(widget.location.name),
          subtitle: Text(widget.location.coordinates),
          trailing: IconButton(
            icon: isFavorite
                ? Icon(Icons.favorite, color: cupertinoTheme.primaryColor)
                : const Icon(Icons.favorite_border),
            onPressed: () {
              if (isFavorite) {
                // removeFromFavorites(widget.location['name']);
                isFavorite = false;
              } else {
                setState(() {
                  // addToFavorites(widget.location['name']);
                  isFavorite = true;
                });
              }
            },
          ),
          contentPadding: const EdgeInsets.only(left: 15, right: 0),
        ),
        
        _image == null? CircularProgressIndicator(color: cupertinoTheme.primaryColor) :
        Image.memory(
          key: widget.key,
          _image!,
        //   // fit: BoxFit.fill,
        //   // height: 210,
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(widget.location.desc,
              // style: mainTheme.textTheme.bodySmall,
              textAlign: TextAlign.justify),
        ),
        Container(
          margin: const EdgeInsets.only(right: 10, top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              OutlinedButton(
                onPressed: () {},
                style: mainTheme.outlinedButtonTheme.style,
                child: const Text('Подробнее'),
              ),
              const SizedBox(
                width: 8,
              ),
              OutlinedButton.icon(
                onPressed: () async {
                  List splitted =
                      widget.location.coordinates.toString().split(', ');
                  Uri uri = Uri.parse(
                      'yandexmaps://maps.yandex.ru/?rtext=~${splitted[0]},${splitted[1]}');
                  try {
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  } catch (e) {
                    if (Platform.isAndroid) {
                      Fluttertoast.showToast(
                          msg: 'Не найдено приложение Яндекс.Карт');
                    } else {
                      showCupertinoDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CupertinoAlert(context);
                          });
                    }
                  }
                },
                style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green),
                icon: const Icon(Icons.route),
                label: const Text('Маршрут'),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
      ]),
    );
  }
}
