import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  getUser()async{
    final user = FirebaseAuth.instance.currentUser;
    print(user?.email??"no email");

  }

  @override
  void initState() {
    getUser();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
           title: Text('Note Home'),centerTitle: true,toolbarHeight: 100,
        actions: [
          IconButton(onPressed: ()async{
            await FirebaseAuth.instance.signOut();
            Navigator.pushReplacementNamed(context, 'Login');
          }, icon: Icon(Icons.exit_to_app,color: Colors.white,))
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
