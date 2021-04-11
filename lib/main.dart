import 'package:flutter/material.dart';
import 'package:project/front_page.dart';
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
  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("college");
  // final FirebaseFirestore db = FirebaseFirestore.instance.collection("collection");
  Stream<DocumentSnapshot> snapshot = FirebaseFirestore.instance
      .collection("college")
      .doc('Block A')
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: new AppBar(),
        body: StreamBuilder(
          stream: collectionReference.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, int index) {
                    return Text(snapshot.data.docs[index]['teacher']);
                    // return Text("numijjjm");
                  });
            }
            return LinearProgressIndicator();
          },
        ),
      ),
    );
  }
}
