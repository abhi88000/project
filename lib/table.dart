import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:searchable_dropdown/searchable_dropdown.dart';

class Dropdown extends StatefulWidget {
  @override
  _DropdownState createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  bool asTabs = false;
  String selectedValue;
  String preselectedValue = "Select One";
  List<int> selectedItems = [];
  final List<DropdownMenuItem> items = [];

  static const String appTitle = "Search Choices demo";
  final String locations =
      "A-206_IBM-Lab_Director , A-205_CRIE-Lab , A-208_Manager-CSDIS , A-103_Admin-Offiice , A-207_IQAC , A-303_Meeting_Room ";

  @override
  void initState() {
    String wordPair = "";
    locations
        .replaceAll(",", "")
        .replaceAll(".", "")
        .split(" ")
        .forEach((word) {
      if (wordPair.isEmpty) {
        wordPair = word + " ";
      } else {
        wordPair += word;
        if (items.indexWhere((item) {
              return (item.value == wordPair);
            }) ==
            -1) {
          items.add(DropdownMenuItem(
            child: Text(wordPair),
            value: wordPair,
          ));
        }
        wordPair = "";
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, Widget> widgets;
    for (int i = 0; i < selectedItems.length; i++) {
      print(selectedItems[i]);
    }
    widgets = {
      "Select Room No": SearchableDropdown.single(
        items: items,
        value: selectedValue,
        hint: "Select one",
        searchHint: "Select one",
        onChanged: (value) {
          setState(() {
            selectedValue = value;
          });
        },
        isExpanded: true,
      ),
    };

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: LimitedBox(
          child: Column(
            children: [
              Column(
                  children: widgets
                      .map((k, v) {
                        return (MapEntry(
                            k,
                            Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                    color: Colors.blueAccent,
                                    width: 5.0,
                                  ),
                                ),
                                margin: EdgeInsets.all(20),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    children: <Widget>[
                                      Text("$k:"),
                                      v,
                                    ],
                                  ),
                                ))));
                      })
                      .values
                      .toList()),
              new Text("hello")
            ],
          ),
        ),
      ),
    );
  }
}
