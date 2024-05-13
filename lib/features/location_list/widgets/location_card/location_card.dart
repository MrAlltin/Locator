import 'package:locator/repositories/yandex_maps.dart';

import 'package:flutter/material.dart';


class LocationCard extends StatefulWidget {
  const LocationCard(
      {super.key,
      required this.name,
      required this.coordinates,
      required this.image});
  final String name;
  final String coordinates;
  final String image;

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
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          ListTile(
            // leading: const Icon(Icons.forest),
            leading: const Icon(Icons.forest),
            title: Text(widget.name),
            subtitle: Text(widget.coordinates),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                widget.image,
                fit: BoxFit.scaleDown,
                height: 210,
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                OutlinedButton(
                  onPressed: () {
                    debugPrint('Pressed: "Подробнее" in ${widget.name}');
                  },
                  child: const Text('Подробнее'),
                ),
                const SizedBox(
                  width: 8,
                ),
                OutlinedButton.icon(
                  onPressed: () => OpenYandexMaps().createRoute(widget.coordinates, widget.name),
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
        ],
      ),
    );
  }
}
