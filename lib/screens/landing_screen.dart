import 'package:flutter/material.dart';
import 'package:olbs_final_project/screens/sign_in_screen.dart';
import 'package:olbs_final_project/screens/sign_up_screen.dart';
class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: const AssetImage('assets/images/bg.png'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.6),
                BlendMode.darken,
              ))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 70,),


                //-------------------------------------------------//


                const Text('If you are an old user ',style: TextStyle(
                  fontSize: 23, color: Colors.white,fontWeight: FontWeight.bold,
                ),),
                const Text('of OLBS',style: TextStyle(
                  fontSize: 23, color: Colors.white,fontWeight: FontWeight.bold,
                )),
                const Text(' please, Sign In ',style: TextStyle(
                  fontSize: 23, color: Colors.white,fontWeight: FontWeight.bold,
                )),


                //-------------------------------------------------//


                const SizedBox(height: 15,),


                //-------------------------------------------------//


                SizedBox(
                  width: 200,
                  height: 60,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          onPrimary: Colors.white,
                          primary: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          )),
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacement(MaterialPageRoute(builder: (ctx) {
                          return SignInScreen();
                        }));
                      },
                      child: const Text(
                        '     Sign In     ',
                        style: TextStyle(fontSize: 25),
                      )),
                ),


                //-------------------------------------------------//


                const SizedBox(
                  height: 45,
                ),



                //-------------------------------------------------//

                const Text('If you are new  ',style: TextStyle(
                  fontSize: 23, color: Colors.white,fontWeight: FontWeight.bold,
                ),),
                const Text('to OLBS',style: TextStyle(
                  fontSize: 23, color: Colors.white,fontWeight: FontWeight.bold,
                )),
                const Text(' please, Sign UP ',style: TextStyle(
                  fontSize: 23, color: Colors.white,fontWeight: FontWeight.bold,
                )),



                //-------------------------------------------------//


                const SizedBox(height: 10,),


                //-------------------------------------------------//



                SizedBox(
                  width: 200,
                  height: 60,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          onPrimary: Colors.white,
                          primary: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          )),
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (ctx) {
                          return SignUpScreen();
                        }));
                      },
                      child: const Text(
                        '     Sign Up     ',
                        style: TextStyle(fontSize: 25),
                      )),
                ),

                //-------------------------------------------------//


              ],
            ),
          ),
        ),
    );

  }
}
