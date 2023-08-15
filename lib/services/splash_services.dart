import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:uzir/views/home.dart';
import 'package:uzir/views/login_screen.dart';

class SplashServices {
  final _auth = FirebaseAuth.instance;
  void IsLogin(BuildContext context) {
    final user = _auth.currentUser;
    if (user != null) {
      Timer(Duration(seconds: 3), () {
        Navigator.pushNamed(context, HomeScreen.id);
      });
    } else {
      Timer(Duration(seconds: 3), () {
        Navigator.pushNamed(context, LoginScreen.id);
      });
    }
  }
}
