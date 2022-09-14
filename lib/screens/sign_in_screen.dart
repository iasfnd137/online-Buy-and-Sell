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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.withOpacity(0.9),
      body: Column(
        children: [
          SizedBox(height: 20,),
          Container(
            height: 300,
            width: MediaQuery.of(context).size.width*100,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.grey,
                  Colors.black,
                ],
              ),

              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100),),
            ),
            child: Column(
              children: [
                SizedBox(height: 100,),
                Center(child: Text('OLBS',style: TextStyle(color: Colors.white,fontSize: 60,fontWeight: FontWeight.bold),)),
                Text('On-Line Buy & Sell',style: TextStyle(color: Colors.white,fontSize: 35,fontWeight: FontWeight.bold),),
              SizedBox(height: 30,),
              Text('Sign In',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)
              ],
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(top: 20,right: 40,left: 40),
            child: Column(
              children: [
                TextField(
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  controller: emailController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email_outlined,color: Colors.white,),
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
                      hintText: 'Email',
                      fillColor: Colors.black.withOpacity(0.4),
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                      ),
                  ),
                ),
                SizedBox(height: 10,),
                TextField(
                  style: TextStyle(color: Colors.white),
                  obscureText: passwordObsecure,
                  cursorColor: Colors.white,
                  controller: passwordController,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                          icon: Icon(passwordObsecure? Icons.visibility_off : Icons.visibility,color: Colors.white.withOpacity(0.7),
                          ),
                          onPressed: () {
                            setState(() {
                              passwordObsecure = !passwordObsecure;
                            });
                          }),
                      prefixIcon: Icon(Icons.lock_outline,color: Colors.white,),
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
                      hintText: 'Password',
                      fillColor: Colors.black.withOpacity(0.4),
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2,
                          )
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2,
                          )
                      )
                  ),
                ),
                SizedBox(height: 10,),
                TextButton(
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                        return PasswordForgetScreen();
                      }));
                    },
                    child: Text('Forgot Password',style: TextStyle(color: Colors.white,fontSize: 18),)),
              ],
            ),
          ),



          ElevatedButton(
              style: ElevatedButton.styleFrom(
                side: BorderSide(
                  width: 2,color: Colors.black
                ),
                  onPrimary: Colors.white,
                  primary: Colors.grey.withOpacity(0.1),
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
              Text('If You do not have an Acoount?',style: TextStyle(color: Colors.white),),
              TextButton(onPressed: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx){
                 return SignUpScreen();
                }));
              }, child: Text('Sign Up',style: TextStyle(color: Colors.white),))
            ],
          )
        ],
      ),
    );
  }
}
