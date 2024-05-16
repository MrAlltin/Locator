import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:locator/features/profile_app_screen/widgets/profile.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

import '../widgets/widgets.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {


  @override
  Widget build(BuildContext context) {
    return SuperScaffold(
        appBar: SuperAppBar(
            largeTitle: SuperLargeTitle(enabled: false),
            title: const Text('Профиль'),
            searchBar: SuperSearchBar(enabled: false)),
        body: UserPageBody());
  }
}
    // return Center(
    //     child: CupertinoButton(
    //   child: const Text('Выйти'),
    //   onPressed: () {
    //     signOut();
    //     profileUpdateNotifier.notifyProfileUpdate();
    //   },
    // ));