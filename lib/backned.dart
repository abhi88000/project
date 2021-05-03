import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Backend extends StatefulWidget {
  @override
  _BackendState createState() => _BackendState();
}

class _BackendState extends State<Backend> {
  String abc = "A-101";
  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("college");
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: new AppBar(
          title: new Text(''),
          backgroundColor: Colors.lightGreen[100],
        ),
        body: SafeArea(
          child: StreamBuilder(
            stream: collectionReference.snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, int index) {
                      // String vall = snapshot.data.docs[index]['room name'];
                      return Text(snapshot.data.docs[index]['room name']);
                    });
                //       return Text(collectionReference
                // .doc('room name')
                // .snapshots().toString());
              }
              return LinearProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}


