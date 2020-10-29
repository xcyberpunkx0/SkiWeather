import 'package:Minimal_Weather/screens/locations_screen.dart';
import 'package:flutter/material.dart';
import 'package:Minimal_Weather/screens/loading_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: LoadingScreen(),
    );
  }
}
