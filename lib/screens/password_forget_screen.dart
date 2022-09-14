import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:olbs_final_project/screens/new_password_screen.dart';
import 'package:olbs_final_project/screens/sign_in_screen.dart';

class PasswordForgetScreen extends StatefulWidget {
  const PasswordForgetScreen({Key? key}) : super(key: key);

  @override
  State<PasswordForgetScreen> createState() => _PasswordForgetScreenState();
}
class _PasswordForgetScreenState extends State<PasswordForgetScreen> {
  var emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.withOpacity(0.9),
      body: Column(
        children: [
          SizedBox(height: 24,),
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
                SizedBox(
                  height: 70,
                ),
                Center(child: Text('OLBS',style: TextStyle(color: Colors.white,fontSize: 60,fontWeight: FontWeight.bold),)),
                Text('On-Line Buy & Sell',style: TextStyle(color: Colors.white,fontSize: 35,fontWeight: FontWeight.bold),),
                SizedBox(height: 60,),
                Text('ResetPassword',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
              ],
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(top: 20,left: 40,right: 40),
            child: Column(
              children: [
                TextField(
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  controller: emailController,
                  decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
                      prefixIcon: Icon(Icons.email_outlined,color: Colors.white,),
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
              ],
            ),
          ),

          SizedBox(height: 10,),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                side: BorderSide(
                  width: 2,color: Colors.black,
                ),
                  onPrimary: Colors.white,
                  primary: Colors.grey.withOpacity(0.1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  )
              ),
              onPressed: ()async{
                var email = emailController.text;
                if(email.isEmpty){
                  Fluttertoast.showToast(msg: 'please Provide Email');
                  return;
                }
                FirebaseAuth auth = FirebaseAuth.instance;
                try{
                  await auth.sendPasswordResetEmail(email: email);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.black,
                    content: Text('PasswordReset Email has been Sent to Your Email'
                    ,style: TextStyle(color: Colors.grey,fontSize: 15),),

                  ) );
                }on FirebaseAuthException catch(e){
                  Fluttertoast.showToast(msg: e.toString());
                }
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                   return SignInScreen();
                }));
              },
              child: Text('Send Link',style: TextStyle(fontSize: 15),)),
        ],
      ),
    );
  }
}
