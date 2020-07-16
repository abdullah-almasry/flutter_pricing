import 'package:flutter/material.dart';
import 'package:flutter_api/home.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

void main() => runApp(WaveDemoApp());

class WaveDemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wave Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(title: 'اسعارك'),
    );
  }
}

