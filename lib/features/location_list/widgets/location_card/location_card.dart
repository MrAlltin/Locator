import 'dart:io';

import 'package:device_apps/device_apps.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:locator/repositories/yandex_maps.dart';

import 'package:flutter/material.dart';
import 'package:locator/themes/main_theme/export.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LocationCard extends StatefulWidget {
  const LocationCard({super.key, required this.location});
  final Map<String, dynamic> location;

  @override
  State<LocationCard> createState() => _LocationCardState();
}

class _LocationCardState extends State<LocationCard> {
  bool fav = false;
  Icon favorite_icon = Icon(Icons.favorite_border);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(15),
      color: mainCard,
      child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
        ListTile(
          // leading: const Icon(Icons.forest),
          leading: const Icon(Icons.forest),
          title: Text(widget.location['name']),
          subtitle: Text(widget.location['coordinates']),
          trailing: IconButton(
            icon: favorite_icon,
            onPressed: () {
              if (fav) {
                fav = false;
                favorite_icon = Icon(Icons.favorite_border);
              } else {
                fav = true;
                favorite_icon = favorite_icon = Icon(Icons.favorite);
              }
              setState(() {});
            },
          ),
          contentPadding: const EdgeInsets.only(left: 15, right: 0),
        ),
        Image.asset(
          widget.location['image'],
          fit: BoxFit.fill,
          // height: 210,
        ),
        const SizedBox(
          height: 8,
        ),
        Card(
            color: childrenCard,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(widget.location['desc'],
                  // style: mainTheme.textTheme.bodySmall,
                  textAlign: TextAlign.justify),
            )),
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
                      widget.location['coordinates'].toString().split(', ');
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
