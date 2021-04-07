import 'package:flutter/material.dart';
import 'package:project/front_page.dart';
import 'package:project/table.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: FrontPage()));
  }
}
