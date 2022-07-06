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
    debugShowCheckedModeBanner: false,
  ));
}
