import 'package:flutter/material.dart';

import '../widgets/drawer.dart';
import 'item screens/items_screen_cars.dart';
import 'item screens/items_screen_charity.dart';
import 'item screens/items_screen_fur.dart';
import 'item screens/items_screen_houses.dart';
import 'item screens/items_screen_laptop.dart';
import 'item screens/items_screen_mob.dart';
import 'msg_screen.dart';

class ContentScreen extends StatelessWidget {
  const ContentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(.2),
      appBar: AppBar(
        backgroundColor: Colors.grey.withOpacity(.7),

        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                  return MessagesScreen();
                }));
              },
              icon: const Icon(Icons.textsms_outlined)),
        ],
        centerTitle: true,
        title: const Text(
          'OLBS',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      drawer: DrawerW(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Opacity(
          opacity: 0.8,
          child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 30,
                crossAxisSpacing: 30,
              ),
              children: [
                InkWell(
                  onTap: (){

                    Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                      return ItemsScreenMob();

                    }));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20)),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: const DecorationImage(
                              image: AssetImage('assets/images/mobile.png'),
                              fit: BoxFit.cover)),

                    ),
                  ),
                ),



                //---------------------------//



                InkWell(
                  onTap: (){

                    Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                      return ItemsScreenCars();

                    }));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20)),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: const DecorationImage(
                              image: AssetImage('assets/images/cars.png'),
                              fit: BoxFit.cover)),

                    ),
                  ),
                ),



                                     //---------------------------//



                InkWell(
                  onTap: (){

                    Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                      return ItemsScreenHouses();

                    }));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20)),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: const DecorationImage(
                              image: AssetImage('assets/images/houses.png'),
                              fit: BoxFit.cover)),

                    ),
                  ),
                ),



                //---------------------------//




                InkWell(
                  onTap: (){

                    Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                      return ItemsScreenLaptop();

                    }));
                  },
                  child: Container(
                    decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(20)),
                    child: Container(

                      decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(20),
                        image: const DecorationImage(

                            image: AssetImage('assets/images/comp.png'),
                            fit: BoxFit.cover
                        ),
                      ),
                    ),
                  ),
                ),



                //---------------------------//







                InkWell(
                  onTap: (){

                    Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                      return ItemsScreenFur();

                    }));
                  },
                  child: Container(
                    decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(20)),
                    child: Container(

                      decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(20),
                        image: const DecorationImage(

                            image: AssetImage('assets/images/fur.png'),
                            fit: BoxFit.cover
                        ),
                      ),
                    ),
                  ),
                ),



                //---------------------------//




                InkWell(
                  onTap: (){

                    Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                      return ItemsScreenCarity();

                    }));
                  },
                  child: Container(
                    decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(20)),
                    child: Container(

                      decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(20),
                        image: const DecorationImage(

                            image: AssetImage('assets/images/charity.png'),
                            fit: BoxFit.cover
                        ),
                      ),
                    ),
                  ),
                ),



                //---------------------------//
              ]),
        ),
      ),
    );
  }
}
