import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ndialog/ndialog.dart';
import 'package:olbs_final_project/screens/content_screen.dart';
import 'package:olbs_final_project/screens/password_forget_screen.dart';
import 'package:olbs_final_project/screens/profile_screen.dart';
import 'package:olbs_final_project/screens/sign_up_screen.dart';
class SignInScreen extends StatefulWidget {
  SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
     var emailController= TextEditingController();

     var passwordController= TextEditingController();

     bool passwordObsecure = true;
     double screenHeight = 0;

     double screenWidth = 0;

     Color primary = Colors.teal;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 24,),
          Container(
            height: 250,
            width: MediaQuery.of(context).size.width*100,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.grey,
                  primary,
                ],
              ),

              borderRadius: BorderRadius.only(bottomRight: Radius.circular(80),),
            ),
            child: Column(
              children: [
                SizedBox(height: 100,),
                Center(child: Text('OLBS',style: TextStyle(color: Colors.white,fontSize: 60,fontWeight: FontWeight.bold),)),
                Text('On-Line Buy & Sell',style: TextStyle(color: Colors.white,fontSize: 35,fontWeight: FontWeight.bold),),
              ],
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(top: 20,right: 40,left: 40),
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.only(bottom: screenHeight / 30),
                    child: Text('Sign In',style: TextStyle(color: primary,fontSize: 20,fontWeight: FontWeight.bold),)),
                Container(
                  margin: EdgeInsets.only(bottom: screenHeight / 50),
                  width: screenWidth,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: screenWidth / 6,
                        child: Icon(
                          Icons.email_outlined,
                          color: primary,
                          size: screenWidth / 15,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: screenWidth / 12),
                          child: TextField(
                            controller: emailController,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: InputDecoration(
                              contentPadding:
                              EdgeInsets.symmetric(vertical: screenHeight / 35),
                              border: InputBorder.none,
                              hintText: 'enter your email',
                            ),
                            maxLines: 1,

                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: screenHeight / 50),
                  width: screenWidth,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: screenWidth / 6,
                        child: Icon(
                          Icons.lock_outline,
                          color: primary,
                          size: screenWidth / 15,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: screenWidth / 12),
                          child: TextField(
                            obscureText: passwordObsecure,
                            controller: passwordController,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  icon: Icon(passwordObsecure? Icons.visibility_off : Icons.visibility,color: primary,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      passwordObsecure = !passwordObsecure;
                                    });
                                  }),

                              contentPadding:
                              EdgeInsets.symmetric(vertical: screenHeight / 35),
                              border: InputBorder.none,
                              hintText: 'enter your Password',
                            ),
                            maxLines: 1,

                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                        return PasswordForgetScreen();
                      }));
                    },
                    child: Text('Forgot Password',style: TextStyle(color: primary,fontSize: 18),)),
              ],
            ),
          ),



          ElevatedButton(
              style: ElevatedButton.styleFrom(
                side: BorderSide(
                  width: 2,color: primary
                ),
                  onPrimary: Colors.white,
                  primary: primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  )
              ),
              onPressed: ()async{
                var email = emailController.text;
                var password = passwordController.text;
                if(email.isEmpty || password.isEmpty){
                  Fluttertoast.showToast(msg: 'please filled all the textField');
                  return;
                }
                if(password.length<6){
                  Fluttertoast.showToast(msg: 'your password must be greater then 5 character');
                }
                ProgressDialog progressDialog = ProgressDialog(
                    context,
                    title: Text('SignIn'),
                    message: Text('Please wait')
                );
                progressDialog.show();
                try{
                  FirebaseAuth auth = FirebaseAuth.instance;
                  UserCredential userCredential = await auth.signInWithEmailAndPassword(
                      email: email,
                      password: password,
                  );
                  progressDialog.dismiss();
                  if(userCredential.user != null){
                    Fluttertoast.showToast(msg: 'SignIn Successfully');
                    Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                    return ContentScreen();
                    }));
                    progressDialog.dismiss();
                  }else{
                    Fluttertoast.showToast(msg: 'Field');
                  }
                }on FirebaseAuthException catch(e){
                  progressDialog.dismiss();
                  if(e.code=='invalid-email'){
                    Fluttertoast.showToast(msg: 'Wrong email');
                    return;
                  }
                  if(e.code =='wrong-password'){
                    Fluttertoast.showToast(msg: 'plz provide valid Password');
                  return;
                  }
                  if(e.code == 'user-not-found'){
                    Fluttertoast.showToast(msg: 'User not found');
                    return;
                  }
                }
              },
              child: Text('Sign In',style: TextStyle(fontSize: 15),)),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('If You do not have an Acoount?',style: TextStyle(color: primary),),
              TextButton(onPressed: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx){
                 return SignUpScreen();
                }));
              }, child: Text('Sign Up',style: TextStyle(color: primary),))
            ],
          )
        ],
      ),
    );
  }
}
