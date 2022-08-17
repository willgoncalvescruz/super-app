import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:super_app/home_super_app.dart';
import 'package:native_notify/native_notify.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  NativeNotify.initialize(1341, 'raM4eXaYwQL1frPvWGfQaE', null, null);
  //Firebase.initializeApp();
  //await Firebase.initializeApp();
  /*   if (kDebugMode) {
    print(await getData());
  }
  if (kDebugMode) {
    print(await getDataWeather());
  } */

  Widget home = SplashScreenView(
    navigateRoute: const HomeSuperApps(),
    duration: 4000,
    imageSize: 200,
    imageSrc: "assets/images/apps.png",
    text: "Super-App",
    //textType: TextType.ScaleAnimatedText,
    textType: TextType.ColorizeAnimationText,
    textStyle: const TextStyle(
      fontSize: 35.0,
    ),
    colors: const [
      Colors.blue,
      Colors.white,
      Colors.red,
    ],
    backgroundColor: Colors.red,
  );

  runApp(MaterialApp(
    title: 'Mobile - Super App',
    theme: ThemeData(primarySwatch: Colors.blue),
    home: home,
    debugShowCheckedModeBanner: false,
  ));
}
