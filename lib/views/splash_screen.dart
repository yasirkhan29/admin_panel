import 'package:flutter/material.dart';
import 'package:uzir/colors/color.dart';
import 'package:uzir/services/splash_services.dart';

class SplashScreen extends StatefulWidget {
  static String id = 'SplashScreen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashServices = SplashServices();
  @override
  void initState() {
    splashServices.IsLogin(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Text(
            'Welcome to\n Blogging App',
            style: TextStyle(
              color: MyColors.Color_Orange,
              fontSize: 30,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ))
        ],
      ),
    );
  }
}
