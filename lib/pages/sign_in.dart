import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notewithfirebase/pages/home_page.dart';
import 'package:notewithfirebase/pages/register.dart';


enum FormType { login, register }

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}
TextEditingController emailController = TextEditingController();
TextEditingController passController = TextEditingController();
TextEditingController nameController = TextEditingController();
final authInstance = FirebaseAuth.instance;

var _formKey = GlobalKey<FormState>();


createUser(BuildContext context) async {
  var formKey=_formKey.currentState;
  if(formKey!.validate()){
    formKey.save();
    try {
   UserCredential userCredential=  await authInstance.createUserWithEmailAndPassword(email: emailController.text, password: passController.text);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {

        AwesomeDialog(context: context,body: Text('Password is to weak'),title: "Error",headerAnimationLoop: true,width: 200,dialogBackgroundColor: Colors.indigo)..show();


      } else if (e.code == 'email-already-in-use') {
        AwesomeDialog(context: context,body: Text('the account -already-in-use'),title: "Error",titleTextStyle: TextStyle(fontSize: 40))..show();

      }

    } catch (e) {}

  }
  else{

  }

}
signInUser(BuildContext context)async{
  try {
  UserCredential userSign=  await authInstance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passController.text
    );
  return userSign;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      AwesomeDialog(context: context,body: Text('No user found for that email.'),title: "Error",)..show();
    } else if (e.code == 'wrong-password') {
      AwesomeDialog(context: context,body: Text('Wrong password provided for that user.'),title: "Error",)..show();
    }
  }
}
getUser()async{
  final user = FirebaseAuth.instance.currentUser;
  print(user?.email??"no email");

}
class _SignInPageState extends State<SignInPage> {
  bool obs = true;
  FormType auth = FormType.login;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 35.0,
                  ),
                  Container(
                    width: 250,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(16.0),
                        bottomRight: Radius.circular(16.0),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        auth == FormType.login
                            ? Text(
                                '   Welcome Back',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    letterSpacing: 2.0),
                              )
                            : Text(
                                '   Create Account',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    letterSpacing: 2.0),
                              ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 65,
                  ),
                  Center(
                      child: auth == FormType.login
                          ? Text(
                              'Login Account',
                              style: TextStyle(fontSize: 26, letterSpacing: 2.0),
                            )
                          : Text(
                              'Create Account',
                              style: TextStyle(fontSize: 26, letterSpacing: 2.0),
                            )),
                  SizedBox(
                    height: 60,
                  ),
                  if (auth == FormType.register)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextFormField(controller: nameController,
                        decoration: InputDecoration(  border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        prefixIcon: Icon(Icons.person_outline),
                          suffixIcon: InkWell(onTap: (){
                            nameController.clear();
                          },child: Icon(Icons.clear)),
                          hintText: 'Name',

                        ),

                        validator:(value){
                          if (value!.isEmpty) {
                            return 'Please enter your name!';
                          }
                        }                       ,

                      )
                    ),
                  if (auth == FormType.register)
                    SizedBox(
                      height: 24,
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child:  TextFormField(controller: emailController,
                      decoration: InputDecoration(  border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                          prefixIcon: Icon(Icons.email_outlined),
                          suffixIcon: InkWell(onTap: (){
                            emailController.clear();
                          },child: Icon(Icons.clear)),
                          hintText: 'Email'
                      ),
                         validator:(value){
                           if (value!.isEmpty) {
                             return 'Please enter your email!';
                           }
                         }                       ,






                    )
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextFormField(controller: passController,
                      obscureText: true,
                      decoration: InputDecoration(  border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                          prefixIcon: Icon(Icons.security),
                          suffixIcon: InkWell(onTap: (){
                            passController.clear();
                          },child: Icon(Icons.clear)),
                          hintText: 'Password'
                      ),
                      validator:(value){
                        if (value!.isEmpty) {
                          return 'Please enter your password!';
                        }
                      }                       ,


                    ),
                  ),
                  SizedBox(
                    height: 64,
                  ),
                  Center(
                      child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
                    width: 200,
                    height: 50,
                    child: MaterialButton(
                      onPressed: () async{
                        if(_formKey.currentState!.validate()){
                          if(auth==FormType.register)
                          {
                           UserCredential response= await createUser(context);
                           if(response.user!.email!=null)
                             Navigator.push(context, MaterialPageRoute(builder: (builder)=>HomePage()));

                           }
                          else{

                            print('user credintal ==null');
                          }


                          if(auth==FormType.login){
                             UserCredential userSignIn=await signInUser(context);
                            if(userSignIn.user!.email!=null){
                              Navigator.push(context, MaterialPageRoute(builder: (builder)=>HomePage()));

                            }
                                print('login tap here');
                          }
                        }
                        else {
                          print("UnAuth");
                        }



                        FormType.register==true;
                      },
                      child: auth == FormType.login
                          ? Text(
                              'Sign In ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  letterSpacing: 4),
                            )
                          : Text(
                              'Create ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  letterSpacing: 4),
                            ),
                      color: Colors.indigo,
                    ),
                  )),
                  SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      auth == FormType.login
                          ? Text('If dont have an Account?')
                          : Text(' Have an Account?'),
                      InkWell(
                          onTap: () {},
                          child: auth == FormType.login
                              ? InkWell(
                                  onTap: () {
                                    setState(() {
                                     emailController.clear();
                                     passController.clear();
                                     nameController.clear();
                                      auth = FormType.register;
                                      _formKey.currentState!.reset();
                                    });
                                  },
                                  child: Text(
                                    ' Register',
                                    style: TextStyle(color: Colors.blue),
                                  ))
                              : InkWell(
                                  onTap: () {
                                    setState(() {
                                      _formKey.currentState!.reset();

                                      auth = FormType.login;
                                    });
                                  },
                                  child: Text(
                                    ' Sign In',
                                    style: TextStyle(color: Colors.blue),
                                  ))),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
