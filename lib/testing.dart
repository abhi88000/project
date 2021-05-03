import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:popup_card/popup_card.dart';
import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'dart:async';

class Ontop extends StatefulWidget {
  static String destination = 'A-303';

  @override
  _OntopState createState() => _OntopState();
}

class _OntopState extends State<Ontop> {
  static String destination;
  int _cameraOcr = FlutterMobileVision.CAMERA_BACK;
  String _textValue = "PRESS THE CAMERA BUTTON";
  String desti;
  void initState() {
    super.initState();
    setState(() {
      var firebase = FirebaseFirestore.instance.collection("college").doc("A-101").snapshots();
    });
  }

  String room_no, adf;
  List<String> rooms = [
    "A-101_Meeting_Room ",
    "A-303_IBM-Lab_Director",
    "A-205_CRIE-Lab",
    "A-208_Manager-CSDIS",
    "A-103_Admin-Offiice",
    "A-207_IQAC",
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: qwerty(context),
        floatingActionButton: PopupItemLauncher(
          tag: 'test',
          child: Material(
            color: Colors.white,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: const Icon(
              Icons.navigation_sharp,
              size: 56,
            ),
          ),
          popUp: PopUpItem(
            padding: EdgeInsets.all(8),
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            elevation: 3,
            tag: 'test',
            child: new StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("college")
                    .doc("A-101").snapshots(),
                    
                builder: (context, snapshot) {
                  // if (!snapshot.hasData) {
                  //   return new CircularProgressIndicator();
                  // }
                  var userDocument = snapshot.data;
                  print(destination);
                  return Column(
                    children: [
                      inside("Block", userDocument['Block']),
                      inside("Room no", userDocument['room no']),
                      inside("Teacher ", userDocument['teacher']),
                      inside("Room name ", userDocument['room name']),
                      inside("Description of the destination ",
                          userDocument['description']),
                      new TextButton( 
                          onPressed: null, child: new Text("Confirm"))
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }

  Widget inside(String a, String b) {
    return new Column(
      children: [
        new Text(
          a,
          style: TextStyle(
              fontStyle: FontStyle.italic, fontSize: 13, color: Colors.brown),
        ),
        new Text(
          b,
          style: TextStyle(
              fontStyle: FontStyle.normal, fontSize: 15, color: Colors.orange[900]),
        ),
        new SizedBox(
          height: 20,
        )
      ],
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

  Widget qwerty(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: new AppBar(
            backgroundColor: Colors.blueGrey,
            title: new Text("SELECT FIELDS"),
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
                  adf = destination.toString();
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
}

// class Backe extends StatefulWidget {
//   // final Dropdown d = new Dropdown();
//   String get abc => Dropdown.destination;
//   // String c = abc.toString();

//   @override
//   _BackeState createState() => _BackeState();
// }

// class _BackeState extends State<Backe> {
//   @override
//   Widget build(BuildContext context,) {
//     return new StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection("A-101")
//             .doc("A-101")
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return new CircularProgressIndicator();
//           }
//           var userDocument = snapshot.data;
//           //desti = userDocument["teacher"];
//           // print(abc);
//           return new Text(userDocument['description']);
//         });
//   }
// }
