import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:super_app/home_super_app.dart';
import 'package:super_app/screens/conversor.dart';

void main() async {
  if (kDebugMode) {
    print(await getData());
  }

  runApp(MaterialApp(
    title: 'Aulas - Mobile',
    theme: ThemeData(primarySwatch: Colors.blue),
    home: const HomeSuperApps(),
  ));
}

/* var request =
    Uri.parse("http://api.hgbrasil.com/finance?format=json%key=60df7606");

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}
 */