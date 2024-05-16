import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

import '../../models/models.dart';

class FavoritesPage extends StatefulWidget {
  final String name;

  const FavoritesPage({super.key, required this.name});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final List<int> favorites_id = [1, 2];
  List<FavoriteItem> favorites = [];
  final String key = 'favorites';

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return SuperScaffold(
      appBar: SuperAppBar(
          largeTitle: SuperLargeTitle(
            enabled: false,
          ),
          // brightness: Brightness.light,
          title: const Text('Избранное'),
          searchBar: SuperSearchBar(placeholderText: 'Поиск')),
      body: const SizedBox(),
    );
  }
}
