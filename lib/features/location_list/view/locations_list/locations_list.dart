import 'package:flutter/material.dart';
import '../../widgets/widgets.dart';
import 'package:locator/repositories/locations.dart';

class LocationsList extends StatefulWidget {
  const LocationsList({super.key, required this.name});
  final String name;

  @override
  State<LocationsList> createState() => _LocationsListState();
}

class _LocationsListState extends State<LocationsList> {
  final List locations = GetLocations().get_locations();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.name),
      // ),
      // bottomNavigationBar: BottomAppBar(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.black,
        selectedIconTheme: theme.iconTheme,
        unselectedItemColor: theme.primaryColor,
        onTap: (int i) {
          debugPrint('Нажат элемент $i');
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Поиск'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Избранное'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Профиль')
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        debugPrint(locations[0]['name'].toString());
      }),
      body: CustomScrollView(slivers: [
        SliverAppBar(
          backgroundColor: Color.fromARGB(255, 77, 180, 80),
          title: Text(widget.name),
          centerTitle: true,
        ),
        SliverList.separated(itemBuilder: (context, index) => LocationCard(
            name: locations[index]['name'],
            coordinates: locations[index]['coordinates'],
            image: locations[index]['image']),
            separatorBuilder: (context, index) => const SizedBox(
              width: 1,
            ),
        itemCount: locations.length)]
      ),
    );
    // body: ListView.separated(
        
        
    // // body: MainCards(),
    // ) // This trailing comma makes auto-formatting nicer for build methods.
    // ;
  }
}
