import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:super_app/home_super_app.dart';

void main() async {
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
    title: 'Aulas - Mobile',
    theme: ThemeData(primarySwatch: Colors.blue),
    home: home,
    debugShowCheckedModeBanner: false,
  ));
}
