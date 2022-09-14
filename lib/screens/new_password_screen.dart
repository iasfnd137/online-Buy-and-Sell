import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:olbs_final_project/screens/sign_in_screen.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({Key? key}) : super(key: key);

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  var newPasswordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.withOpacity(0.9),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 40,right: 40,top: 170),
          child: Column(
            children: [
              Center(child: Text('OLBS',style: TextStyle(color: Colors.white,fontSize: 60,fontWeight: FontWeight.bold),)),
              Text('On-Line Buy & Sell',style: TextStyle(color: Colors.white,fontSize: 35,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              TextField(
                cursorColor: Colors.white,
                controller: newPasswordController,
                decoration: InputDecoration(
                    hintText: 'enter new password',
                    fillColor: Colors.black.withOpacity(0.4),
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 2,
                        )
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 2,
                        )
                    )
                ),
              ),
              SizedBox(height: 10,),
              TextField(
                cursorColor: Colors.white,
                controller: confirmPasswordController,
                decoration: InputDecoration(
                    hintText: 'confirm password',
                    fillColor: Colors.black.withOpacity(0.4),
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 2,
                        )
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 2,
                        )
                    )
                ),
              ),
              SizedBox(height: 10,),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      onPrimary: Colors.white,
                      primary: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      )
                  ),
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                       return SignInScreen();
                    }));
                  },
                  child: Text('Change Password',style: TextStyle(fontSize: 25),)),
            ],
          ),
        ),
      ),
    );
  }
}
