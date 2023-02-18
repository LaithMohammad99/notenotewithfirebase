import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
  final auth=FirebaseAuth.instance;
  final user=FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                onPressed: () async {
                  try {
                     await auth.createUserWithEmailAndPassword(
                      email: 'laith@gmail.com',
                      password: 'laith123456789',
                    );
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      print('The password provided is too weak.');
                    } else if (e.code == 'email-already-in-use') {
                      print('The account already exists for that email.');
                    }
                    if(user?.emailVerified==false){
                      await user?.sendEmailVerification();

                    }
                  } catch (e) {
                    print(e);
                  }
                  //if service no connection  the catch see it
                },
                child: Text('Create User'),
                color: Colors.red,
              ),
              SizedBox(height: 20,),
              MaterialButton(
                onPressed: () async {
                  try {
                  await   auth.signInWithEmailAndPassword(
                        email: 'laith@gmail.com',
                        password: 'laith123456789'
                    );
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      print('No user found for that email.');
                    } else if (e.code == 'wrong-password') {
                      print('Wrong password provided for that user.');
                    }
                  }
                  //if service no connection  the catch see it
                },
                child: Text('Sign in User'),
                color: Colors.blueAccent,
              ),
              SizedBox(height: 20,),
              MaterialButton(
                onPressed: () async {
               UserCredential cred=  await  signInWithGoogle();
               print(cred);
                },
                child: Text('sign with gooole'),
                color: Colors.amber,
              ),
            ],
          ),
        ));
  }
}

///how to add anonymously account
// final  userCredential = await FirebaseAuth.instance.signInAnonymously();
// print(userCredential.user?.uid??"asdasd");
