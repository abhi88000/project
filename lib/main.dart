import 'package:flutter/material.dart';
import 'package:project/backned.dart';
import 'package:project/dropdown.dart';
import 'package:project/front_page.dart';
// import 'package:project/table.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project/testing.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:project/table.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // return Backend();
    // return Dropdown();
    // return FrontPage();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
       body: SafeArea(
         child: new SplashScreen(
          seconds: 0,
          navigateAfterSeconds: new Ontop(),
          title: new Text('CAMPUS NAVIAGTION MIET', style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic,),),
          image: new Image.asset('mietlogo.png'),
          backgroundColor: Colors.white,
          styleTextUnderTheLoader: new TextStyle(),
          photoSize: 100.0,
          loaderColor: Colors.red[900]
),
       ),
      ),
    );
  }
}
