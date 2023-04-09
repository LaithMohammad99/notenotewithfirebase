import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetData extends StatefulWidget {
  const GetData({Key? key}) : super(key: key);

  @override
  State<GetData> createState() => _GetDataState();
}

class _GetDataState extends State<GetData> {
  getData() async {
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    QuerySnapshot querySnapshot = await users.get();

    List<QueryDocumentSnapshot> listDocs = querySnapshot.docs;
    listDocs[0].data();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data'),
      ),
      body: Column(),
    );
  }
}
