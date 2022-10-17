import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

var request =
    Uri.parse("https://api.hgbrasil.com/finance?format=json&key=994e1ad6");
var requestWeather =
    Uri.parse("https://api.hgbrasil.com/weather?format=json&key=994e1ad6");

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

Future<Map> getDataWeather() async {
  http.Response response = await http.get(requestWeather);
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
        fontSize: 30.0,
      ),
      colors: const [
        Colors.green,
        Colors.blue,
        Colors.red,
      ],
      backgroundColor: Colors.white,
    );

    return MaterialApp(
      title: 'CONVERSOR DE MOEDAS',
      home: home,
      theme: ThemeData(
          hintColor: Colors.grey[400],
          primaryColor: Colors.black,
          inputDecorationTheme: InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Colors.grey, width: 2.0)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(35.0),
                borderSide: const BorderSide(color: Colors.black)),
            hintStyle: const TextStyle(color: Colors.black),
          )),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  TextEditingController realController = TextEditingController();
  TextEditingController dolarController = TextEditingController();
  TextEditingController euroController = TextEditingController();

  late double dolar;
  late double euro;
  late String condition;
  late String description;

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
        backgroundColor: Colors.grey[700],
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _clearAll,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FutureBuilder<Map>(
              future: getData(), // a Future<String> or null
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return const Text('Aperte o botão para Iniciar');
                  case ConnectionState.waiting:
                    return Center(
                      child: Column(
                        children: const [
                          CircularProgressIndicator(
                            backgroundColor: Colors.green,
                            valueColor:
                                AlwaysStoppedAnimation(Colors.transparent),
                            strokeWidth: 4.0,
                          ),
                          SizedBox(height: 100),
                          Text(
                            'Carregando dados',
                            style: TextStyle(color: Colors.black, fontSize: 25),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    );
                  default:
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text(
                          'Erro ao carregar dados :(',
                          style: TextStyle(color: Colors.black, fontSize: 25),
                          textAlign: TextAlign.center,
                        ),
                      );
                    } else {
                      dolar =
                          snapshot.data!["results"]["currencies"]["USD"]["buy"];
                      euro =
                          snapshot.data!["results"]["currencies"]["EUR"]["buy"];

                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Container(
                                padding:
                                    const EdgeInsets.all(15), // Border width
                                decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    shape: BoxShape.circle),
                                child: ClipOval(
                                  child: SizedBox.fromSize(
                                    size: const Size.fromRadius(
                                        60), // Image radius
                                    child: const Icon(Icons.monetization_on,
                                        size: 120, color: Colors.green),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 25),
                              TextField(
                                controller: realController,
                                onChanged: _realChanged,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: "Reais",
                                  labelStyle: TextStyle(color: Colors.green),
                                  prefixText: "R\$",
                                ),
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 25),
                              ),
                              const Divider(),
                              TextField(
                                controller: dolarController,
                                onChanged: _dolarChanged,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: "Dólares",
                                  labelStyle:
                                      TextStyle(color: Colors.blueAccent),
                                  prefixText: "US\$",
                                ),
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 25),
                              ),
                              const Divider(),
                              TextField(
                                controller: euroController,
                                onChanged: _euroChanged,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: "Euros",
                                  labelStyle: TextStyle(color: Colors.red),
                                  prefixText: "€",
                                ),
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 25),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                }
              },
            ),
            FutureBuilder<Map>(
              future: getDataWeather(), // a Future<String> or null
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return const Text('Aperte o botão para Iniciar');
                  case ConnectionState.waiting:
                    return const Text("");
                  default:
                    if (snapshot.hasError) {
                      return const Text("Erro ao carrregar dados do clima :(");
                    } else {
                      condition = snapshot.data!["results"]["condition_code"];
                      description = snapshot.data!["results"]["description"];

                      return SizedBox(
                        height: 300,
                        width: 500,
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(20), // Border width
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  shape: BoxShape.rectangle),
                              child: Column(children: [
                                Text("Condição do Tempo $condition°"),
                                const SizedBox(height: 15),
                                Text(description),
                              ]),
                            ),
                          ],
                        ),
                      );
                    }
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

//reaproveitamento de Widgets só alterar "label" e "prefix" > buildTextField("Reais","R\$")
Widget buildTextField(String label, String prefix, TextEditingController c) {
  return TextField(
    decoration: InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.black),
      prefixText: prefix,
    ),
    style: const TextStyle(color: Colors.black, fontSize: 25),
  );
}
