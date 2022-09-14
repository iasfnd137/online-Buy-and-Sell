
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:olbs_final_project/widgets/drawer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/item models/item_houses_model.dart';
import '../../models/number_model.dart';
import '../../models/olbs_model.dart';
import '../../services/hero_dialog_route.dart';
import '../../widgets/popups/pop_up_houses_widget.dart';



class ItemsScreenHouses extends StatefulWidget {
  const ItemsScreenHouses({Key? key}) : super(key: key);

  @override
  State<ItemsScreenHouses> createState() => _ItemsScreenHousesState();
}

class _ItemsScreenHousesState extends State<ItemsScreenHouses> {
  User? user;
  DatabaseReference? userRef;
  UserModel? userModel;
  ItemModelHouse? itemModel;
  DatabaseReference? itemRef;
  DatabaseReference? housesRef;
  var time = DateTime.now().toString();
  DatabaseReference? numRef;
  PhoneModel? phoneModel;

  getNumberDetail() async {
    DatabaseEvent snapshot = await numRef!.once();

    phoneModel = PhoneModel.fromMap(
        Map<String, dynamic>.from(snapshot.snapshot.value as Map));

    setState(() {});
  }

  getUserDetail() async {
    DatabaseEvent snapshot = await userRef!.once();

    userModel = UserModel.fromMap(
        Map<String, dynamic>.from(snapshot.snapshot.value as Map));

    setState(() {});
  }

  Stream<List<ItemModelHouse>> readItem() => FirebaseFirestore.instance
      .collection('houses')
      .orderBy('date', descending: true)
      .snapshots()
      .map((snapshots) =>
          snapshots.docs.map((doc) => ItemModelHouse.fromMap(doc.data())).toList());


  updateFirestore() {
    if (itemRef != null) {
      FirebaseFirestore.instance
          .collection('houses')
          .doc(time)
          .update({'displayPic': userModel!.image,'num' : phoneModel!.number,});
    }
  }


  openwhatsapp(ItemModelHouse item) async{
    var whatsapp = item.num;
    var whatsappURlAndroid = "whatsapp://send?phone=""$whatsapp";
    var whatsAnd = Uri.parse(whatsappURlAndroid);
    var whatappURLIos ="https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
    var whatsIo = Uri.parse(whatappURLIos);
    if(Platform.isIOS){
      // for iOS phone only
      if( await launchUrl(whatsAnd)){
        await launchUrl(whatsIo);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("whatsapp no installed")));

      }

    }else{
      // android , web
      if( await launchUrl(whatsAnd)){
        await launchUrl(whatsAnd);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("whatsapp no installed")));

      }


    }
  }


  //----------------------------------init state-----------------------------------------------//

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      userRef = FirebaseDatabase.instance.ref().child('users').child(user!.uid);
    }
    getUserDetail();

    if(user != null){
      numRef = FirebaseDatabase.instance.ref().child('detail').child(user!.uid);
    }
    getNumberDetail();

  }


  String netimage =
      'https://i.pinimg.com/564x/ca/52/e6/ca52e6e168595f767c2121a68cc227b0.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.withOpacity(.2),
        appBar: AppBar(
          backgroundColor: Colors.grey.withOpacity(.7),
          centerTitle: true,
          title: const Text('Houses'),
        ),
        floatingActionButton: GestureDetector(
          onTap: () {
            Navigator.of(context).push(HeroDialogRoute(
                builder: (context) {
                  return const AddTodoPopupCardHouses();
                },
                settings: const RouteSettings()));
          },
          child: Hero(
            tag: heroAddTodo,
            child: Material(
              color: Colors.blue,
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
              child: const Icon(
                Icons.add_rounded,color: Colors.white,
                size: 50,
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        drawer: DrawerW(),
        body:

            // ignore: unrelated_type_equality_checks
            userModel?.uid != null
                ? StreamBuilder<List<ItemModelHouse>>(
                    stream: readItem(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        final items = snapshot.data!;
                        return ListView(
                          children: items.map(buildItems).toList(),
                        );
                      }
                    },
                  )
                : const Center(child: CircularProgressIndicator()));

  }

  Widget buildItems(ItemModelHouse items) => items.itemPic != null
      ? Padding(
    padding: const EdgeInsets.all(15.0),
    child: SizedBox(
      height: 565,
      child: Stack(
        children: [
          Positioned(
            top: 305,
            left: 0,
            right: 0,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width*100,
                    height: 250,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.5),
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey.withOpacity(.7)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Padding(
                            padding: const EdgeInsets.only(top: 10.0,left: 10,right: 10),
                            child: Row(
                              children: [

                                const Text('Item Name: ',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),),

                                Text(' ${items.itemName}',
                                  style: const TextStyle(
                                      fontSize: 16,

                                      color: Colors.white),
                                ),



                                const Spacer(),
                                Row(
                                  children: [

                                    items.itemPrice == '' ?


                                    const Text('Item Price: Null',
                                      style: TextStyle(
                                          fontSize: 16,

                                          color: Colors.white),
                                    )
                                        :
                                    const Text('Item Price: ',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),),

                                    Text(' ${items.itemPrice}',
                                      style: const TextStyle(
                                          fontSize: 16,

                                          color: Colors.white),
                                    ),
                                  ],
                                ),



                              ],
                            ),
                          ),


                          const SizedBox(height: 10,),
                          SingleChildScrollView(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0,left: 8.0,right: 8.0),
                                child: Column(
                                  children: [

                                    const SizedBox(height: 10),
                                    SizedBox(
                                      height: 90,

                                      child: SingleChildScrollView(
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Detail: ',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                            Expanded(
                                              child: Text(
                                                ' ${items.detail}',
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ),

                          const Spacer(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                  radius: 30,
                                  backgroundImage: items.displayPic != null
                                      ? NetworkImage(
                                      items.displayPic.toString())
                                      : NetworkImage(netimage)),
                              const SizedBox(
                                width: 15,
                              ),
                              items.username != null
                                  ? Text(
                                '${items.username}',
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )
                                  : const Text(
                                'Username',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                      backgroundColor: Colors.black,
                                      context: context,
                                      builder: (ctx) {
                                        return Wrap(
                                          children: [
                                            Card(
                                              child: ListTile(
                                                onTap: () {
                                                  print(openwhatsapp(items));
                                                  openwhatsapp(items);
                                                  Navigator.of(context)
                                                      .pop();
                                                },
                                                leading: CircleAvatar(
                                                    radius: 20
                                                    ,child: ClipOval(child: Image.asset('assets/images/wat.png',))),
                                                title: const Text(
                                                    'Contact Via Whatsapp'),
                                                tileColor: Colors.grey,
                                              ),
                                            ),
                                            Card(
                                              child: ListTile(
                                                onTap: () {
                                                  Navigator.of(context)
                                                      .pop();
                                                },
                                                leading: const Icon(
                                                  Icons.dialpad_outlined,
                                                  color: Colors.white,
                                                ),
                                                title: const Text(
                                                    'Save Number to Dialer'),
                                                tileColor: Colors.grey,
                                              ),
                                            ),
                                            Card(
                                              child: ListTile(
                                                onTap: () {
                                                  Navigator.of(context)
                                                      .pop();
                                                },
                                                leading: const Icon(
                                                  Icons.chat,
                                                  color: Colors.white,
                                                ),
                                                title: const Text(
                                                    'Message Seller now                                       (Coming Soon...)'),
                                                tileColor: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        );
                                      });
                                },
                                icon: const Icon(
                                  Icons.phone_forwarded_outlined,
                                  size: 35,
                                ),
                                color: Colors.white,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          items.itemPic != null
              ? Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width*100,
                height: 320,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.black, width: 3),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      items.itemPic.toString(),
                    ),
                  ),
                ),
              ),
            ],
          )
              : const Text("wait"),
        ],
      ),
    ),
  )
      : Padding(
    padding: const EdgeInsets.all(20.0),
    child: SizedBox(
      height: 260,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 7.5,
            right: 5,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0,left: 15),
                  child: Row(
                    children: [
                      const Text('Item Name: ',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),),

                      Text(' ${items.itemName}',
                        style: const TextStyle(
                            fontSize: 16,

                            color: Colors.white),
                      ),


                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width*100,
                  height: 260,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.5),
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey.withOpacity(.7)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20,),
                        SingleChildScrollView(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, left: 8.0, right: 8.0),
                              child: Column(
                                children: [
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    height: 120,
                                    child: SingleChildScrollView(
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Detail: ',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight:
                                                FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                          Expanded(
                                            child: Text(
                                              ' ${items.detail}',
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                                radius: 30,
                                backgroundImage: items.displayPic != null
                                    ? NetworkImage(
                                    items.displayPic.toString())
                                    : NetworkImage(netimage)),
                            const SizedBox(
                              width: 15,
                            ),
                            items.username != null
                                ? Text(
                              '${items.username}',
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )
                                : const Text(
                              'Username',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    backgroundColor: Colors.black,
                                    context: context,
                                    builder: (ctx) {
                                      return Wrap(
                                        children: [
                                          Card(
                                            child: ListTile(
                                              onTap: () {
                                                openwhatsapp(items);
                                                Navigator.of(context)
                                                    .pop();
                                              },
                                              leading: CircleAvatar(
                                                  radius: 20
                                                  ,child: ClipOval(child: Image.asset('assets/images/wat.png',))),
                                              title: const Text(
                                                  'Contact Via Whatsapp'),
                                              tileColor: Colors.grey,
                                            ),
                                          ),
                                          Card(
                                            child: ListTile(
                                              onTap: () {
                                                Navigator.of(context)
                                                    .pop();
                                              },
                                              leading: const Icon(
                                                Icons.dialpad_outlined,
                                                color: Colors.white,
                                              ),
                                              title: const Text(
                                                  'Save Number to Dialer'),
                                              tileColor: Colors.grey,
                                            ),
                                          ),
                                          Card(
                                            child: ListTile(
                                              onTap: () {
                                                Navigator.of(context)
                                                    .pop();
                                              },
                                              leading: const Icon(
                                                Icons.chat,
                                                color: Colors.white,
                                              ),
                                              title: const Text(
                                                  'Message Seller now                                       (Coming Soon...)'),
                                              tileColor: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      );
                                    });
                              },
                              icon: const Icon(
                                Icons.phone_forwarded_outlined,
                                size: 35,
                              ),
                              color: Colors.white,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
