import 'package:flutter/material.dart';
import 'package:super_app/home_super_app.dart';

void main() {
  runApp(MaterialApp(
    title: 'Aulas - Mobile',
    theme: ThemeData(primarySwatch: Colors.blue),
    home: const HomeSuperApps(),
  ));
}
