//
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

var request =
    Uri.parse("http://api.hgbrasil.com/finance?format=json%key=60df7606");

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class SplashScreenHomeConversor extends StatelessWidget {
  const SplashScreenHomeConversor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget home = SplashScreenView(
      navigateRoute: const Home(),
      duration: 3000,
      imageSize: 130,
      imageSrc: "assets/images/conversor.png",
      text: "CONVERSOR DE MOEDAS",
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
      title: 'CONVERSOR DE MOEDAS',
      home: home,
      theme: ThemeData(
          hintColor: Colors.amber,
          primaryColor: Colors.white,
          inputDecorationTheme: const InputDecorationTheme(
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            hintStyle: TextStyle(color: Colors.white),
          )),
      //
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController realController = TextEditingController();
  TextEditingController dolarController = TextEditingController();
  TextEditingController euroController = TextEditingController();

  late double dolar;
  late double euro;

  void _clearAll() {
    realController.text = "";
    dolarController.text = "";
    euroController.text = "";
  }

  void _realChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double real = double.parse(text);
    dolarController.text = (real / dolar).toStringAsFixed(2);
    euroController.text = (real / euro).toStringAsFixed(2);
    if (kDebugMode) {
      print(text);
    }
  }

  void _dolarChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double dolar = double.parse(text);
    realController.text = (dolar * this.dolar).toStringAsFixed(2);
    euroController.text = (dolar * this.dolar / euro).toStringAsFixed(2);
    if (kDebugMode) {
      print(text);
    }
  }

  void _euroChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double euro = double.parse(text);
    realController.text = (euro * this.euro).toStringAsFixed(2);
    dolarController.text = (euro * this.euro / dolar).toStringAsFixed(2);
    if (kDebugMode) {
      print(text);
    }
  }

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("\$ Conversor de moedas \$"),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _clearAll,
            )
          ],
        ),
        backgroundColor: Colors.black38,

        // ignore: unnecessary_new
        body: FutureBuilder<Map>(
          future: getData(), // a Future<String> or null
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Text('Aperte o botão para Iniciar');
              case ConnectionState.waiting:
                return const Center(
                    child: Text(
                  'Carregando dados',
                  style: TextStyle(color: Colors.blue, fontSize: 25),
                  textAlign: TextAlign.center,
                ));

              default:
                if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      'Erro ao carregar dados :(',
                      style: TextStyle(color: Colors.blue, fontSize: 25),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  dolar = snapshot.data!["results"]["currencies"]["USD"]["buy"];
                  euro = snapshot.data!["results"]["currencies"]["EUR"]["buy"];

                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          const Icon(Icons.monetization_on,
                              size: 150, color: Colors.deepPurple),
                          const SizedBox(height: 15),
                          TextField(
                            controller: realController,
                            onChanged: _realChanged,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: "Reais",
                              labelStyle: TextStyle(color: Colors.deepPurple),
                              prefixText: "R\$",
                            ),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 25),
                          ),
                          const Divider(),
                          TextField(
                            controller: dolarController,
                            onChanged: _dolarChanged,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: "Dólares",
                              labelStyle: TextStyle(color: Colors.deepPurple),
                              prefixText: "US\$",
                            ),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 25),
                          ),
                          const Divider(),
                          TextField(
                            controller: euroController,
                            onChanged: _euroChanged,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: "Euros",
                              labelStyle: TextStyle(color: Colors.deepPurple),
                              prefixText: "€",
                            ),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 25),
                          ),
                        ],
                      ),
                    ),
                  );
                }

              //
            }
          },
        ));
  }
}

//reaproveitamento de Widgets só alterar "label" e "prefix" > buildTextField("Reais","R\$")
Widget buildTextField(String label, String prefix, TextEditingController c) {
  return TextField(
    decoration: InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.deepPurple),
      prefixText: prefix,
    ),
    style: const TextStyle(color: Colors.white, fontSize: 25),
  );
}
