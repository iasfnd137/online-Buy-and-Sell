import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ndialog/ndialog.dart';
import 'package:olbs_final_project/screens/sign_in_screen.dart';
class SignUpScreen extends StatefulWidget {
   SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final nameController = TextEditingController();

  final cnicController = TextEditingController();

  final emailController= TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

   bool passwordObsecure = true;

   bool confirmPasswordObsecure = true;
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
            Text('OLBS',style: TextStyle(color: Colors.white,fontSize: 60,fontWeight: FontWeight.bold),),
            Text('Create Account',style: TextStyle(color: Colors.white,fontSize: 35,fontWeight: FontWeight.bold),),
          ],
        ),
        ),
       Padding(
         padding: const EdgeInsets.only(top: 20.0,right: 40,left: 40),
         child: Column(
           children: [
             Container(
               margin: EdgeInsets.only(bottom: screenHeight / 70),
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
                       Icons.person,
                       color: primary,
                       size: screenWidth / 15,
                     ),
                   ),
                   Expanded(
                     child: Padding(
                       padding: EdgeInsets.only(right: screenWidth / 12),
                       child: TextField(
                         controller: nameController,
                         enableSuggestions: false,
                         autocorrect: false,
                         decoration: InputDecoration(
                           contentPadding:
                           EdgeInsets.symmetric(vertical: screenHeight / 35),
                           border: InputBorder.none,
                           hintText: 'enter your name',
                         ),
                         maxLines: 1,

                       ),
                     ),
                   ),
                 ],
               ),
             ),
             Container(
               margin: EdgeInsets.only(bottom: screenHeight / 70),
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
                       Icons.textsms_outlined,
                       color: primary,
                       size: screenWidth / 15,
                     ),
                   ),
                   Expanded(
                     child: Padding(
                       padding: EdgeInsets.only(right: screenWidth / 12),
                       child: TextField(
                         controller: cnicController,
                         enableSuggestions: false,
                         autocorrect: false,
                         decoration: InputDecoration(
                           contentPadding:
                           EdgeInsets.symmetric(vertical: screenHeight / 35),
                           border: InputBorder.none,
                           hintText: 'enter your Cnic',
                         ),
                         maxLines: 1,

                       ),
                     ),
                   ),
                 ],
               ),
             ),
             Container(
               margin: EdgeInsets.only(bottom: screenHeight / 70),
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
               margin: EdgeInsets.only(bottom: screenHeight / 70),
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
             Container(
               margin: EdgeInsets.only(bottom: screenHeight / 70),
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
                         obscureText: confirmPasswordObsecure,
                         controller: confirmPasswordController,
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
                           hintText: 'Confirm Password',
                         ),
                         maxLines: 1,

                       ),
                     ),
                   ),
                 ],
               ),
             ),
             ElevatedButton(
                 style: ElevatedButton.styleFrom(
                   side: BorderSide(width: 2,color: primary),
                     onPrimary: Colors.white,
                     primary: primary,
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(8),

                     )
                 ),
                 onPressed: ()async{
                   var name = nameController.text;
                   var cnic = cnicController.text;
                   var email = emailController.text;
                   var password = passwordController.text;
                   var confirmPassword = confirmPasswordController.text;
                   if(name.isEmpty || cnic.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty){
                     Fluttertoast.showToast(msg: 'please filled All the textfield');
                     return;
                   }
                   if(cnic.length != 13){
                     Fluttertoast.showToast(msg: 'Please provide 13 digit Cnic number');
                     return;
                   }
                   if(password != confirmPassword){
                     Fluttertoast.showToast(msg: 'Password does not match ');
                     return;
                   }
                   if(password.length < 6 && confirmPassword.length<6){
                     Fluttertoast.showToast(msg: 'your password must bi greater then 5 character');
                     return;
                   }
                   ProgressDialog progressDialog = ProgressDialog(
                     context,
                     title: Text('SignUp'),
                     message: Text('please wait'),
                   );
                   progressDialog.show();
                   try{
                     FirebaseAuth auth = FirebaseAuth.instance;
                     UserCredential userCredential =await auth.createUserWithEmailAndPassword(
                         email: email,
                         password: password);

                     User? user = userCredential.user;
                     final databaseRef= FirebaseDatabase.instance.ref();
                     databaseRef.child('users').child(user!.uid).set(
                         {
                           'uid':user.uid,
                           'name':name,
                           'cnic':cnic,
                           'email':email,
                           'password':password,
                           'dt':DateTime.now().millisecondsSinceEpoch,
                           'image':'',
                         }
                     );

                     progressDialog.dismiss();
                     if(userCredential.user !=null){
                       Fluttertoast.showToast(msg: 'SignUp successfully');
                       Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                         return SignInScreen();
                       }));
                       progressDialog.dismiss();
                     }
                     else{
                       Fluttertoast.showToast(msg: 'field');
                     }
                   }  on FirebaseAuthException catch(e){
                     if(e.code == "email-already-in-use"){
                       Fluttertoast.showToast(msg: 'email already Exist');
                     }
                     progressDialog.dismiss();
                     if(e.code == 'weak-password'){
                       Fluttertoast.showToast(msg: 'plz provide strong Password');
                     }
                   }catch (e){
                     Fluttertoast.showToast(msg: 'Something went wrong');
                     progressDialog.dismiss();
                   }
                   //Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                   //return SignInScreen();
                   //}));
                 },
                 child: Text('Sign Up',style: TextStyle(fontSize: 15),)),
             ],
         ),
       ),
       Spacer(),
       Row(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Text('If You Have Already an Acoount?',style: TextStyle(color: primary),),
           TextButton(onPressed: (){
             Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx){
               return SignInScreen();
             }));
           }, child: Text('Sign In',style: TextStyle(color: primary),))
         ],
       )
      ],
    ),
    );

  }
}
