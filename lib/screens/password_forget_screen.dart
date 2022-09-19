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
                SizedBox(
                  height: 70,
                ),
                Center(child: Text('OLBS',style: TextStyle(color: Colors.white,fontSize: 60,fontWeight: FontWeight.bold),)),
                Text('On-Line Buy & Sell',style: TextStyle(color: Colors.white,fontSize: 35,fontWeight: FontWeight.bold),),
              ],
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(top: 20,left: 40,right: 40),
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.only(bottom: screenHeight / 50),
                    child: Text('ResetPassword',style: TextStyle(color: primary,fontSize: 20,fontWeight: FontWeight.bold),)),
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
              ],
            ),
          ),

          SizedBox(height: 10,),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                side: BorderSide(
                  width: 2,color: primary,
                ),
                  onPrimary: Colors.white,
                  primary: primary,
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
