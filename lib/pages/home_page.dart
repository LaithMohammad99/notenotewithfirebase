import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //to see is auth true or false
  getCurrentUser() async {
    final user = FirebaseAuth.instance.currentUser;
    print(user?.email ?? "no email");
  }
  getAllData() async {
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    await users.orderBy('age',descending: true).limit(2).get().then(( value) {
      value.docs.forEach(( element) {

        print(element.data());
        print("=======================================");
      });
    });
  }

  getOneDoc() async {
    DocumentReference docs = FirebaseFirestore.instance.collection('users').doc(
        "0Kzc5PRvmU6cbiEPjKvH");
    await docs.get().then((value) {

      print(value.data());
      print("----------------------------------------,,-------------------");
    });
  }
  //where("lang",here....)
  //where in is used for more if
  //array contain Check one value
  //array containAny more on check
  getDataByAge() async {
    var userRef = FirebaseFirestore.instance.collection("users");
    await userRef.get().then((QuerySnapshot<Map<String, dynamic>> value) {
      value.docs.forEach((element) {
        print(element.data()["user_name"]);
      });
    });
  }

  filterTowCollection ()async{
    var reference= FirebaseFirestore.instance.collection('users');
   await reference.get().then((value) =>
    {
      value.docs.forEach((element) {
        print('user name ${element.data()['user_name']}');
        print('======================================================');
        print('age${element.data()['phone']}');
        print('======================================================');
        print('email ${element.data()['email']}');
        print('======================================================');




      })
    });
  }
  liveConnectionFireBase()async{
    FirebaseFirestore.instance.collection('users').snapshots().listen((event) {
      event.docs.forEach((element) {
        print(element.data()['age']);

      });

    });
  }

  addDataFromFireStoreToDocs(){
   var userRef= FirebaseFirestore.instance.collection('users');
   // userRef.add({"user_name":"laith new",
   //              "age":22,
   //              "email":"laithnew@gmail.com",
   //              "phone":0785121484});
    userRef.doc('4').set({
      "name":"ahmad",
      "age":2
    });
  }
  upDateDataFireStoreIntoDocs(){
    var userRef=FirebaseFirestore.instance.collection('users');
    userRef.doc('4').update({});

  }

  @override
  void initState() {

    liveConnectionFireBase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Note Home'),
          centerTitle: true,
          toolbarHeight: 100,
          actions: [
            IconButton(onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, 'Login');
            }, icon: Icon(Icons.exit_to_app, color: Colors.white,))
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Home'),
          ],
        ),
      ),
    );
  }
}
