import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:super_app/screens/chat_online/chat_screen.dart';
import 'package:super_app/screens/chat_online/firestore/main_firestore.dart';

class SplashScreenHomeChatOnline extends StatelessWidget {
  const SplashScreenHomeChatOnline({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget home = SplashScreenView(
      navigateRoute: const ChatScreen(),
      //navigateRoute: const MyApp(),

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
          iconTheme: IconThemeData(color: Colors.indigo[900]!),
          inputDecorationTheme: InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.indigo[900]!),
              borderRadius: BorderRadius.circular(30.0),
            ),
            /*    focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Colors.black)), */
            hintStyle: TextStyle(color: Colors.indigo[900]!),
          )),
    );
  }
}
