import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';
import 'package:locator/repositories/locations.dart';
import 'package:locator/themes/main_theme/export.dart';

class CupertinoLocationList extends StatefulWidget {
  const CupertinoLocationList({super.key, required this.name});
  final String name;

  @override
  State<CupertinoLocationList> createState() => _CupertinoLocationListState();
}

class _CupertinoLocationListState extends State<CupertinoLocationList> {
  int _currentIndex = 0;
  final List<Widget> _tabs = [
    Tab1(),
    Tab2(),
    Tab3(),
  ];

  @override
  Widget build(BuildContext context) {
    final bool iphonex = MediaQuery.of(context).size.height >= 812.0;
    final double bottomPadding = iphonex ? 16.0 : 0.0;
    // final double bottomPadding = 16.0;
    return Container(
        color: appBarColor,
        padding: EdgeInsets.only(bottom: bottomPadding),
        // decoration: BoxDecoration(border: Border(bottom: BorderSide.none)),
        child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            activeColor: cupertinoTheme.primaryColor,
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
                debugPrint('Нажат Tab #$index');
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home),
                label: 'Главная',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.search),
                label: 'Tab 2',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person),
                label: 'Tab 3',
              ),
            ],
          ),
          tabBuilder: (context, index) => CupertinoPageOne(),
        ),
/// The line `      ),` is closing the `SafeArea` widget in the `build` method of the
/// `_CupertinoLocationListState` class. It is closing the parentheses for the `SafeArea` widget and the
/// `child` property of the `SafeArea` widget.
      // ),
    );
  }

  SafeArea CupertinoPageOne() {
    return SafeArea(child:
    CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        brightness: Brightness.light,
        middle: Text(widget.name),
      ),
      child: Scaffold(
        body: _tabs[_currentIndex],
      ),
    ));
  }
}

class Tab1 extends StatelessWidget {
  final List locations = GetLocations().get_locations();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) => LocationCard(location: locations[index]),
        itemCount: locations.length,
        separatorBuilder: (context, index) => const SizedBox(
              width: 1,
            ));
  }
}

class Tab2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Tab 2 Content'),
    );
  }
}

class Tab3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Tab 3 Content'),
    );
  }
}
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: 0,
      //   showSelectedLabels: false,
      //   showUnselectedLabels: false,
      //   selectedItemColor: Colors.black,
      //   selectedIconTheme: theme.iconTheme,
      //   unselectedItemColor: theme.primaryColor,
      //   onTap: (int i) {
      //     debugPrint('Нажат элемент $i');
      //   },
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Главная',
      //     ),
      //     BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Поиск'),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.favorite), label: 'Избранное'),
      //     BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Профиль')
      //   ],
      // ),
    //   child: CustomScrollView(slivers: [
    //     SliverAppBar(
    //       backgroundColor: Color.fromARGB(255, 77, 180, 80),
    //       title: Text(widget.name),
    //       centerTitle: true,
    //     ),
    //     SliverList.separated(itemBuilder: (context, index) => LocationCard(
    //         name: locations[index]['name'],
    //         coordinates: locations[index]['coordinates'],
    //         image: locations[index]['image']),
    //         separatorBuilder: (context, index) => const SizedBox(
    //           width: 1,
    //         ),
    //     itemCount: locations.length)]
    //   ),
    // );
    // body: ListView.separated(
        
        
    // // body: MainCards(),
    // ) // This trailing comma makes auto-formatting nicer for build methods.
    // ;
//   }
// }
