//
import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class TesteResponsivo extends StatelessWidget {
  const TesteResponsivo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget home = SplashScreenView(
      navigateRoute: const Home(),
      duration: 3000,
      imageSize: 130,
      imageSrc: "assets/images/imc.png",
      text: "IMC",
      textType: TextType.ColorizeAnimationText,
      textStyle: const TextStyle(
        fontSize: 30.0,
      ),
      colors: const [
        Colors.purple,
        Colors.blue,
        Colors.yellow,
        Colors.red,
      ],
      backgroundColor: Colors.grey[700],
    );

    return MaterialApp(
      title: 'IMC',
      home: home,
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    //var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.red,
        body: SafeArea(
          child: Stack(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: LayoutBuilder(
                    builder: (_, constraints) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            width: constraints.maxWidth,
                            height: constraints.maxHeight / 3,
                            color: Colors.red,
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: constraints.maxWidth,
                            height: constraints.maxHeight / 3,
                            color: Colors.yellow,
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: constraints.maxWidth,
                            height: constraints.maxHeight / 3,
                            color: Colors.blue,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
