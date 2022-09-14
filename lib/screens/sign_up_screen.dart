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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey,
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
            Text('OLBS',style: TextStyle(color: Colors.white,fontSize: 60,fontWeight: FontWeight.bold),),
            Text('Create Account',style: TextStyle(color: Colors.white,fontSize: 35,fontWeight: FontWeight.bold),),
          ],
        ),
        ),
       Padding(
         padding: const EdgeInsets.only(top: 20.0,right: 40,left: 40),
         child: Column(
           children: [
             TextField(
               style: TextStyle(color: Colors.white),
               cursorColor: Colors.white,
               controller: nameController,
               decoration: InputDecoration(
                   prefixIcon: Icon(Icons.person,color: Colors.white,),
                   hintText: 'Name',
                   hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
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
             TextField(
               style: TextStyle(color: Colors.white),
               cursorColor: Colors.white,
               controller: cnicController,
               decoration: InputDecoration(
                   prefixIcon: Icon(Icons.password,color: Colors.white,),
                   hintText: 'Cnic',
                   hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
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
             TextField(

               style: TextStyle(color: Colors.white),
               cursorColor: Colors.white,
               controller: emailController,
               decoration: InputDecoration(
                   prefixIcon: Icon(Icons.email_outlined,color: Colors.white,),
                   hintText: 'Email',
                   hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
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
             TextField(
               style: TextStyle(color: Colors.white),
               cursorColor: Colors.white,
               controller: passwordController,
               obscureText: passwordObsecure,
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
                   hintText: 'Password',
                   hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
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
             TextField(
               style: TextStyle(color: Colors.white),
               cursorColor: Colors.white,
               obscureText: confirmPasswordObsecure,
               controller: confirmPasswordController,
               decoration: InputDecoration(
                   suffixIcon: IconButton(
                     onPressed: (){
                       setState(() {
                         //use nor gate
                         confirmPasswordObsecure = !confirmPasswordObsecure;
                       });
                     },
                     icon: Icon(confirmPasswordObsecure? Icons.visibility_off: Icons.visibility,color: Colors.white.withOpacity(0.7),),
                   ),
                   prefixIcon: Icon(Icons.lock_outline,color: Colors.white,),
                   hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
                   hintText: 'Confirm Password',
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
             ElevatedButton(
                 style: ElevatedButton.styleFrom(
                   side: BorderSide(width: 2,color: Colors.black),
                     onPrimary: Colors.white,
                     primary: Colors.grey.withOpacity(0.1),
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
           Text('If You Have Already an Acoount?',style: TextStyle(color: Colors.white),),
           TextButton(onPressed: (){
             Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx){
               return SignInScreen();
             }));
           }, child: Text('Sign In',style: TextStyle(color: Colors.white),))
         ],
       )
      ],
    ),
    );

  }
}
