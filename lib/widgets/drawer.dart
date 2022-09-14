import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:olbs_final_project/screens/about_us.dart';
import '../models/olbs_model.dart';
import '../screens/content_screen.dart';
import '../screens/landing_screen.dart';
import '../screens/profile_screen.dart';

class DrawerW extends StatefulWidget {
  const DrawerW({Key? key}) : super(key: key);

  @override
  State<DrawerW> createState() => _DrawerWState();
}

class _DrawerWState extends State<DrawerW> {
  User? user;
  DatabaseReference? userRef;
  UserModel? userModel;
  String netimage =
      'https://i.pinimg.com/564x/ca/52/e6/ca52e6e168595f767c2121a68cc227b0.jpg';


  GetName(){
    if(userModel?.name != null) {
      return  Text(
          '  ${userModel?.name}   ',
          style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
      ),
      );
    }else{
      return const Text('  User Name  ',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      );
    }
  }

  getUserDetail() async {
    DatabaseEvent snapshot = await userRef!.once();

    userModel = UserModel.fromMap(
        Map<String, dynamic>.from(snapshot.snapshot.value as Map));

   setState(() {

   });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      userRef = FirebaseDatabase.instance.ref().child('users').child(user!.uid);
    }
    getUserDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Colors.black.withOpacity(.6),
        child: ListView(
          children: [
            const SizedBox(
              height: 50,
            ),

            //---------------------------------------------------------------//

            Center(
                child: CircleAvatar(
              radius: 93,
              backgroundColor: Colors.grey.withOpacity(.7),
              child: ClipOval(
                child: SizedBox(
                  width: 180,
                  height: 180,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: userModel?.image == null
                        ? NetworkImage(netimage)
                        : NetworkImage(userModel!.image.toString()),
                  ),
                ),
              ),
            )),
            const SizedBox(
              height: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  color: Colors.grey.withOpacity(.6),
                  child: GetName(),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),

            //---------------------------------------------------------------//

            const SizedBox(
              height: 10,
            ),

            ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                  return const ContentScreen();
                }));
              },
              leading: const Icon(
                Icons.home,
                color: Colors.white,
              ),
              title: const Text(
                'Home',
                style: TextStyle(color: Colors.white),
              ),
            ),

            //---------------------------------------------------------------//

            ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                  return const ProfileScreen();
                }));
              },
              leading: const Icon(
                Icons.person,
                color: Colors.white,
              ),
              title: const Text(
                'Profile',
                style: TextStyle(color: Colors.white),
              ),
            ),

            //---------------------------------------------------------------//

            ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                  return AboutUs();
                }));
              },
              leading: const Icon(
                Icons.group,
                color: Colors.white,
              ),
              title: const Text(
                'About Us',
                style: TextStyle(color: Colors.white),
              ),
            ),

            //-------------------------------------------------------------------------//

            const Divider(
              thickness: 3,
              color: Colors.white,
            ),

            //-------------------------------------------------------------------------//

            ListTile(
              onTap: () {
                Navigator.of(context).pop();
              },
              leading: const Icon(
                Icons.star,
                color: Colors.white,
              ),
              title: const Text(
                'Rate App',
                style: TextStyle(color: Colors.white),
              ),
            ),

            //-------------------------------------------------------------------------//

            ListTile(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Center(child: Text('Are You Sure')),
                        content: const Text('Do You want to Log out'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('No')),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();

                                FirebaseAuth.instance.signOut();
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (ctx) {
                                  return const LandingScreen();
                                }));
                              },
                              child: const Text('yes')),
                        ],
                      );
                    });
              },
              leading: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              title: const Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ));
  }
}

