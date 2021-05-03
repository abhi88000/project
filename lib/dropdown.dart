import 'package:flutter/material.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';
import 'dart:async';


class Dropdown extends StatefulWidget {
  static String destination;

  @override
  _DropdownState createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  
  static String destination;
  int _cameraOcr = FlutterMobileVision.CAMERA_BACK;
  String _textValue = "PRESS THE CAMERA BUTTON";
  String desti;
  void initState() {
    super.initState();
  }

  // ignore: non_constant_identifier_names
  String room_no;
  List<String> rooms = [
    "A-206_IBM-Lab_Director",
    "A-205_CRIE-Lab",
    "A-208_Manager-CSDIS",
    "A-103_Admin-Offiice",
    "A-207_IQAC",
    "A-101_Meeting_Room "
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: new AppBar(
            backgroundColor: Colors.greenAccent,
          ),
          body: Padding(
            padding: const EdgeInsets.all(18.0),
            child:
                Wrap(alignment: WrapAlignment.spaceEvenly, children: <Widget>[
              DropDownField(
                
                strict: false,

                itemsVisibleInDropdown: 2,
                onValueChanged: (dynamic value) {
                  room_no = value;

                },
                value: room_no,
                labelText: 'Current Room no',
                items: rooms,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  new Text(
                    "Press to Detect Current location via Camera",
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                  new IconButton(
                      icon: new Icon(Icons.camera_enhance), onPressed: _read),
                ],
              ),
              new SizedBox(
                height: 70,
              ),
              DropDownField(
                onValueChanged: (dynamic value) {
                  room_no = _textValue;
                  destination = value.toString().substring(0, 5);
                  print(destination);
                },
                value: room_no,
                labelText: 'Destination Room no',
                items: rooms,
              ),
              new SizedBox(
                height: 20,
              ),
            ]),
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
        room_no = _textValue;
      });
    } on Exception {
      texts.add(new OcrText('Failed to recognize text.'));
    }
  }
}

// class Backe extends StatefulWidget {
//   @override
//   _BackeState createState() => _BackeState();
// }

// String destination = Ontop.destination;

// class _BackeState extends State<Backe> {
//   @override
//   Widget build(BuildContext context) {
//     return new StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection('college')
//             .doc(destination)
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return new CircularProgressIndicator();
//           }
//           var userDocument = snapshot.data;
//           //desti = userDocument["teacher"];
//           print(destination);
//           return new Text(userDocument['teacher']);
//         });
//   }
// }

