import 'package:flutter/material.dart';
import 'package:locator/features/location_list/widgets/location_card/location_card.dart';
import 'package:locator/repositories/locations.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';
import 'package:locator/features/location_list/view/view.dart';

class SuperScaffoldApp extends StatefulWidget {
  const SuperScaffoldApp(
      {super.key, required this.name, required this.currentIndex});
  final String name;
  final int currentIndex;

  @override
  State<SuperScaffoldApp> createState() => _SuperScaffoldAppState();
}

class _SuperScaffoldAppState extends State<SuperScaffoldApp> {
  @override
  Widget build(BuildContext context) {
    switch (widget.currentIndex) {
      case 0:
        return HomePage(name: widget.name);
      case 1:
        return FavoritesPage(name: widget.name);
      case 2:
        return const ProfilePage();
      case 3:
    }
    return const Scaffold();
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    final List locations = GetLocations().get_locations();
    return SuperScaffold(
      appBar: SuperAppBar(
          largeTitle: SuperLargeTitle(
            enabled: false,
          ),
          // brightness: Brightness.light,
          title: Text(name),
          searchBar: SuperSearchBar(placeholderText: 'Поиск')),
      body: Scaffold(
        body: ListView.separated(
            itemBuilder: (context, index) =>
                LocationCard(location: locations[index]),
            itemCount: locations.length,
            separatorBuilder: (context, index) => const SizedBox(
                  width: 1,
                )),
      ),
    );
  }
}


