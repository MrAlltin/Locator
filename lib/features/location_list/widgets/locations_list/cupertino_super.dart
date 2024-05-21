import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:locator/features/location_list/widgets/location_card/location_card.dart';
import 'package:locator/models/firebase.dart';
import 'package:locator/repositories/firebase.dart';
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

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.name});
  final String name;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final Reference storageRef = FirebaseStorage.instance.ref();
  final int _perPage = 10;
  int _currentPage = 0;
  List<CustomData> locations = [];
  final int _batchSize = 10;
  DocumentSnapshot? _lastDocument;
  List<Uint8List> _images = [];

  bool isFetched = false;

  @override
  void initState() {
    getData();
    if (!isFetched) {
      // fetchData();
      isFetched = true;
    }
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // fetchData();
        getData();
      }
    });
    debugPrint('_downloadImage');
    _downloadImage();
    super.initState();
  }

  void _downloadImage() async {
    List<Uint8List> _imageList = [];
    debugPrint('hello _downloadImage');
    debugPrint('locations = ' + locations.toString());
    for (var i in locations) {
      debugPrint('i = $i');
      final imagesRef = storageRef.child(i.image);
      imagesRef.getData().then((value) {
        _imageList.add(value!);
      });
    }
    setState(() {
      _images = _imageList;
    });
  }

  Future<void> getData() async {
    List<CustomData> data = [];
    getDataRepository().then((value) {
      setState(() {
        locations.addAll(value);
      });
    });
  }

  Future<void> fetchData() async {
    List<CustomData> data = await downloadInfo(_perPage, _currentPage);
    if (!mounted) {
      return;
    }
    setState(() {
      _currentPage += 1;
      locations.addAll(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SuperScaffold(
      appBar: SuperAppBar(
          largeTitle: SuperLargeTitle(
            enabled: false,
          ),
          // brightness: Brightness.light,
          title: Text(widget.name),
          searchBar: SuperSearchBar(placeholderText: 'Поиск')),
      body: ListView.separated(
          addAutomaticKeepAlives: true,
          // itemBuilder: (context, index) => isFetched
          //     ? LocationCard(location: locations[index])
          //     : const CircularProgressIndicator(),
          itemBuilder: (context, index) {
            if (index == locations.length) {
              getData();
              return CircularProgressIndicator();
            } else {
              return LocationCard(
                key: ValueKey(index),
                location: locations[index],
                // image: _images[index],
              );
            }
          },
          itemCount: locations.length + 1,
          separatorBuilder: (context, index) => const SizedBox(
                width: 1,
              )),
    );
  }
}
