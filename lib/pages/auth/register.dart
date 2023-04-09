import 'package:flutter/material.dart';
import 'package:notewithfirebase/pages/auth/sign_in.dart';
import 'package:notewithfirebase/widget/app_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}
TextEditingController emailController = TextEditingController();
TextEditingController passController = TextEditingController();
TextEditingController nameController = TextEditingController();
class _RegisterPageState extends State<RegisterPage> {
  @override
  void dispose() {

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: SingleChildScrollView(
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
                      Text(
                        '   Register',
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
                    child: Text(
                      'Create Account',
                      style: TextStyle(fontSize: 26, letterSpacing: 2.0),
                    )),
                SizedBox(
                  height: 60,
                ), Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: AppTextFormField(
                    controller: nameController,
                    hint: 'User Name',
                    label: 'User Name',
                    icon: Icon(Icons.email_outlined),
                  ),
                ),

                SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: AppTextFormField(
                    controller: emailController,
                    hint: 'Email',
                    label: 'Email',
                    icon: Icon(Icons.email_outlined),
                  ),
                ),

                SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: AppTextFormField(
                    controller: passController,
                    hint: 'Password',
                    label: 'Password',
                    icon: Icon(
                      Icons.lock,
                    ),
                    obscureText: true,
                    iconSuf: InkWell(
                        onTap: () {}, child: Icon(Icons.remove_red_eye_outlined)),
                  ),
                ),
                SizedBox(
                  height: 64,
                ),
                Center(
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
                      width:210,
                      height: 50,
                      child: MaterialButton(
                        onPressed: () {},
                        child: Text(
                          'Create Account',
                          style: TextStyle(
                              color: Colors.white, fontSize: 18, letterSpacing: 2),
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
                    Text(' have an Account?'),
                    InkWell(
                        onTap: (){
                             Navigator.push(context, MaterialPageRoute(builder: (builder)=>SignInPage()));
                        },
                        child: Text(' Sign In',style: TextStyle(color: Colors.blue),)),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
