import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:locator/features/profile_app_screen/widgets/widgets.dart';

import 'user_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final bool _isRegistering = false;
  bool _isAuthenticated = false;

  @override
  void initState() {
    if (_auth.currentUser !=null){
      _isAuthenticated = true;
    }
    super.initState();
    profileUpdateNotifier.profileUpdateStream.listen((_) {
      setState(() {
        _isAuthenticated ? _isAuthenticated = false : _isAuthenticated = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isAuthenticated) {
      return const UserPage();
    } else {
      return const AuthPage();
    }
  }
}
