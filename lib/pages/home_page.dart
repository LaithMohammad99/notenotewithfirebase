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

  List user = [];
  var noteRef = FirebaseFirestore.instance.collection('note');

  void getAllDataUsers() async {
    var responseBody = noteRef.get();
    await noteRef.get().then((value) {
      value.docs.forEach((element) {
        setState(() {
          user.add(element.data());
        });
      });
    });
  }

  @override
  void initState() {
    getAllDataUsers();

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
            IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacementNamed(context, 'Login');
                },
                icon: Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                ))
          ],
        ),
        body: StreamBuilder(
          stream: noteRef.snapshots(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if(snapshot.hasData) {
              return Container(
                width: 500,
                child: ListView.separated(itemBuilder: (context, index) =>
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                           // Image.network('${snapshot.data.docs['image']}'),
                            Text('${snapshot.data.docs[index].data()['note']}',
                                style: TextStyle(fontSize: 16)),
                            Text('${snapshot.data.docs[index].data()['title']}',
                                style: TextStyle(fontSize: 16)),
                            Text('${snapshot.data.docs[index].data()['userId']}',
                                style: TextStyle(fontSize: 16)),
                          ],


                        ),
                      ),
                    ),
                    separatorBuilder: (context, index) =>
                        Divider(color: Colors.blue,),
                    itemCount: snapshot.data.docs.length),
              );
            }
            if(snapshot.hasError) {
              return Text('ERROR');
            }
            if(snapshot.connectionState==ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
        return Text('State: ${snapshot.connectionState}');
          },
        ),
      ),
    );
  }
}
// user.isEmpty?CircularProgressIndicator(
// color: Colors.cyan,
//
// ): Column(
// children: [
// SizedBox(height: 22,),
// SizedBox(
// height: MediaQuery.of(context).size.height*0.5,
// width: MediaQuery.of(context).size.width,
// child:ListView.separated(itemBuilder: (context, index) =>Container(
// width: 100,
//
// child: Padding(
// padding: const EdgeInsets.all(8.0),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text('${user[index]['user_name']}',style: TextStyle(fontSize: 16),),
// Text('${user[index]['phone']}',style: TextStyle(fontSize: 16)),
// Text('${user[index]['age']}',style: TextStyle(fontSize: 16)),
// ],
//
//
// ),
// ),
// ),
// separatorBuilder: (context,index)=>Divider(color: Colors.blue,),
// itemCount: user.length),
// ),
//
//
// ]
