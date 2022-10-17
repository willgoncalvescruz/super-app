//
import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class SplashScreenHomeImc extends StatelessWidget {
  const SplashScreenHomeImc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget home = SplashScreenView(
      navigateRoute: const Home(),
      duration: 3000,
      imageSize: 130,
      imageSrc: "assets/images/imc.png",
      text: "IMC",
      //textType: TextType.ColorizeAnimationText,
      textType: TextType.ScaleAnimatedText,
      textStyle: const TextStyle(
        fontSize: 30.0,
      ),
      colors: const [
        Colors.purple,
        Colors.blue,
        Colors.yellow,
        Colors.red,
      ],
      backgroundColor: Colors.purple[700],
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
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados!";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seu peso e altura!";
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
        _infoText = "Peso normal ou adequado (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Levemente Acima do Peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 40) {
        _infoText =
            "Obesidade Grau III ou Mórbida(${imc.toStringAsPrecision(4)})";
      }
    });
  }

  void _showAlert(BuildContext context) {
    var textStyle18Green = TextStyle(
        fontSize: 20, color: Colors.purple[700], fontWeight: FontWeight.w500);
    AlertDialog alertResult = AlertDialog(
      backgroundColor: Colors.white,
      content: Stack(
        alignment: Alignment.center,
        textDirection: TextDirection.rtl,
        clipBehavior: Clip.none,
        children: <Widget>[
          Row(
            children: <Widget>[
              const SizedBox(
                //color: Colors.red,
                width: 25,
                height: 150,
                child: Icon(
                  Icons.check_circle_outline_rounded,
                  color: Colors.purple,
                  size: 30.0,
                ),
              ),
              const SizedBox(width: 10),
              Container(
                //color: Colors.red,
                alignment: Alignment.center,
                width: 180,
                height: 150,
                child: Text(
                  'Resultado: \n$_infoText',
                  textAlign: TextAlign.center,
                  style: textStyle18Green,
                ),
              ),
            ],
          ),
        ],
      ),
    );
    showDialog(
        //barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          Future.delayed(
            const Duration(seconds: 5),
            () {
              Navigator.of(context).pop();
            },
          );
          return alertResult;
        });
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        Future.delayed(
          const Duration(seconds: 3),
          () {
            Navigator.of(context).pop();
          },
        );
        return alertResult;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Form(
            key: _formKey,
            child: LayoutBuilder(
              builder: (_, constraints) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const Icon(Icons.person_pin,
                        size: 200.0, color: Colors.deepPurple),
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
                        return null;
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
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Container(
                        alignment: Alignment.center,
                        width: constraints.maxWidth,
                        height: 100,
                        color: Colors.transparent,
                        child: SizedBox(
                          width: 170.0,
                          height: 80.0,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _calculate();
                                _showAlert(context);
                                //_resetFields();
                              }
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.deepPurple),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                        side: const BorderSide(
                                            color: Colors.deepPurple)))),
                            child: const Text(
                              "Calcular",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 25.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      _infoText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.deepPurple, fontSize: 23.0),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
