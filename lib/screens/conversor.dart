//
import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
/* 
void main() {
  runApp(MaterialApp(
    home: SplashScreenHomeConversor(),
  ));
} */

class SplashScreenHomeConversor extends StatelessWidget {
  const SplashScreenHomeConversor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget example1 = SplashScreenView(
      navigateRoute: const Home(),
      duration: 3000,
      imageSize: 130,
      imageSrc: "background.png",
      text: "Splash Screen CONVERSOR",
      textType: TextType.ColorizeAnimationText,
      textStyle: const TextStyle(
        fontSize: 40.0,
      ),
      colors: const [
        Colors.purple,
        Colors.blue,
        Colors.yellow,
        Colors.red,
      ],
      backgroundColor: Colors.white,
    );

    return MaterialApp(
      title: 'Splash screen Demo CONVERSOR',
      home: example1,
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados!";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      if (imc < 18.6) {
        _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso Ideal (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Levemente Acima do Peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 40) {
        _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var textStyle16White = const TextStyle(
        fontSize: 25, color: Colors.white, fontWeight: FontWeight.w500);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetFields,
          )
        ],
      ),
      //backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: LayoutBuilder(
            builder: (_, constraints) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const Icon(Icons.person_outline,
                      size: 120.0, color: Colors.deepPurple),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: "Peso (kg)",
                        labelStyle: TextStyle(color: Colors.deepPurple)),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.deepPurple, fontSize: 25.0),
                    controller: weightController,
                    // ignore: missing_return
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Insira seu Peso!";
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: "Altura (cm)",
                        labelStyle: TextStyle(color: Colors.deepPurple)),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.deepPurple, fontSize: 25.0),
                    controller: heightController,
                    // ignore: missing_return
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Insira sua Altura!";
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Container(
                      alignment: Alignment.center,
                      width: constraints.maxWidth,
                      height: 200,
                      color: Colors.transparent,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _calculate();
                          }
                        },
                        child: const Text(
                          "Calcular",
                          style: TextStyle(color: Colors.white, fontSize: 25.0),
                        ),
                        //color: Colors.deepPurple,
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepPurple,
                          onPrimary: Colors.white,
                          shadowColor: Colors.black,
                          textStyle: textStyle16White,
                          enableFeedback: true,
                          elevation: 1,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    _infoText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.deepPurple, fontSize: 25.0),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
