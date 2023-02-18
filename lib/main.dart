import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notewithfirebase/pages/home_page.dart';
import 'package:notewithfirebase/pages/sign_in.dart';

late bool isLogin;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
 var user= FirebaseAuth.instance.currentUser;
 if(user==null){
   isLogin=false;
   print(isLogin);
 }
 else{
   isLogin=true;
   print(isLogin);

 }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: isLogin?HomePage(): SignInPage(),
      routes:{'Login': (context)=>SignInPage()},
    );
  }
}
