import 'package:flutter/material.dart';
import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';
import 'dart:async';



class FrontPage extends StatefulWidget {
  @override
  _FrontPageState createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {

  int _cameraOcr = FlutterMobileVision.CAMERA_BACK;
  String _textValue = "PRESS THE CAMERA BUTTON";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
       body: new SafeArea(
            child: new Scaffold(
              appBar: new AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                title: new Text(
                  'MIET',
                  style: TextStyle(
                      color: Colors.orange[900],
                      fontSize: 60,
                      fontWeight: FontWeight.bold),
                ),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Text(_textValue),
                    new TextField(
                      
                    ),
                    new Divider(
                      thickness: 1,
                      color: Colors.orange[700],
                    ),
                    new IconButton(
                      onPressed: _read,
                      icon: Icon(
                        Icons.camera_alt_sharp,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ),
    );
  }


 Future<Null> _read() async {
    List<OcrText> texts = [];
    try {
      texts = await FlutterMobileVision.read(
        camera: _cameraOcr,
        waitTap: true,
      );

      setState(() {
        _textValue = texts[0].value;
      });
    } on Exception {
      texts.add(new OcrText('Failed to recognize text.'));
    }
  }
}
