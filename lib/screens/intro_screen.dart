
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'content_screen.dart';
import 'landing_screen.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: IntroductionScreen(

              initialPage: 0,



              //------------------------------------//

              globalHeader: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                   IconButton(onPressed: (){
                     Navigator.of(context)
                         .pushReplacement(MaterialPageRoute(builder: (ctx) {
                       return FirebaseAuth.instance.currentUser == null ? LandingScreen() : ContentScreen();
                     }));
                   }, icon: const Icon(Icons.skip_next,size: 45,color: Colors.orange,))
                  ],
                ),
              ),



              //--------------------------------------//


              dotsDecorator: const DotsDecorator(
                size: Size.square(10),
                activeSize: Size.square(20),
                activeColor: Colors.orange,
                activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(20),left: Radius.zero)),
                spacing: EdgeInsets.symmetric(horizontal: 5.0),

                
              ),



              //------------------------------------//

                showSkipButton: false,
                showBackButton: true,
                showNextButton: true,
                showDoneButton: true,


             //-----------------------------------------//


                next: const Icon(Icons.arrow_forward,size: 40,color: Colors.orange,),
                back: const Icon(Icons.arrow_back,size: 40,color: Colors.orange,),
                done: const Icon(Icons.arrow_forward,size: 40,color: Colors.orange,),


             //-----------------------------------------//

                onDone: () {
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (ctx) {
                    return FirebaseAuth.instance.currentUser == null ? LandingScreen() : ContentScreen();
                  }));
                },


              //------------------------------------------//

                pages: [


                  PageViewModel(
                    title: 'Welcome to OLBS',
                    body:
                        'OLBS is an e-shop where you can buy and sell Products all around Pakistan',
                    image: Image.asset(
                      'assets/images/f3.png',
                      fit: BoxFit.fill,
                    ),
                    decoration: const PageDecoration(
                      imageFlex: 2,
                      // imagePadding: EdgeInsets.only(top: 40),
                    ),
                  ),

                  //------------//


                  PageViewModel(

                    image: Image.asset(
                      'assets/images/f1.png',
                      fit: BoxFit.fill,
                    ),
                    decoration: const PageDecoration(
                      imageFlex: 2,
                      // imagePadding: EdgeInsets.only(top: 40),
                    ),

                    title: 'How does we offer you support',
                    body:
                    'We brought you variety of products all over pakistan ',
                    footer: const Text('Make yourself a Deal & Buy now'),
                  ),



                  //----------------//



                  PageViewModel(

                    image: Image.asset(
                      'assets/images/f4.png',
                      fit: BoxFit.fill,
                    ),
                    decoration: const PageDecoration(
                      imageFlex: 2,
                      // imagePadding: EdgeInsets.only(top: 40),
                    ),

                    title: 'Join Us',
                    body:
                        'Join us and enjoy shopping home',
                  ),

                  //------------//


                ],

              //-----------------------------------------------------------------//
           )));
  }
}
