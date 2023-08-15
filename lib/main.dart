import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:uzir/views/forget_password.dart';
import 'package:uzir/views/home.dart';
import 'package:uzir/views/login_screen.dart';
import 'package:uzir/views/post_details.dart';
import 'package:uzir/views/signup_screen.dart';
import 'package:uzir/views/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        SignUPScreen.id: (context) => SignUPScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        Forgetpassword.id: (context) => Forgetpassword(),
        SplashScreen.id: (context) => SplashScreen(),
        PostDetails.id: (context) => PostDetails(),
      },
    );
  }
}
