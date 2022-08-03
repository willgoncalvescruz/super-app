import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:super_app/screens/chat_online/chat_screen.dart';

class SplashScreenHomeChatOnline extends StatelessWidget {
  const SplashScreenHomeChatOnline({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget home = SplashScreenView(
      navigateRoute: const ChatScreen(),
      duration: 3000,
      imageSize: 130,
      imageSrc: "assets/images/chatonline.png",
      text: "CHAT ONLINE",
      textType: TextType.ColorizeAnimationText,
      textStyle: const TextStyle(
        fontSize: 30.0,
      ),
      colors: const [
        Colors.white,
        Colors.blue,
      ],
      backgroundColor: Colors.indigo[900],
    );

    return MaterialApp(
      title: 'CHAT ONLINE',
      home: home,
      theme: ThemeData(
          hintColor: Colors.grey[400],
          primaryColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.indigo[900]),
          inputDecorationTheme: const InputDecorationTheme(
            /* enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: Colors.grey, width: 5.0),
            ), */
            /*    focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Colors.black)), */
            hintStyle: TextStyle(color: Colors.black),
          )),
    );
  }
}
