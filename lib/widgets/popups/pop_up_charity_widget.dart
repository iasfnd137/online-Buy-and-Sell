import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ndialog/ndialog.dart';

import '../../models/item models/item_charity_model.dart';
import '../../models/number_model.dart';
import '../../models/olbs_model.dart';


//---------------------TAG---------------------------//
const String heroAddTodo = 'add-todo-hero';
//=-----------------------------------------------//

class AddTodoPopupCardCharity extends StatefulWidget {
  /// {@macro add_todo_popup_card}
  const AddTodoPopupCardCharity({Key? key}) : super(key: key);

  @override
  State<AddTodoPopupCardCharity> createState() => _AddTodoPopupCardCharityState();
}

class _AddTodoPopupCardCharityState extends State<AddTodoPopupCardCharity> {
  final detailController = TextEditingController();
  final itemNameController = TextEditingController();
  final itemPriceController = TextEditingController();


  User? user;
  DatabaseReference? userRef;
  UserModel? userModel;
  ItemModelCharity? itemModel;
  DatabaseReference? numRef;
  PhoneModel? phoneModel;

  getNumberDetail() async {
    DatabaseEvent snapshot = await numRef!.once();

    phoneModel = PhoneModel.fromMap(
        Map<String, dynamic>.from(snapshot.snapshot.value as Map));

    setState(() {});
  }

  File? pickedImage;
  var imgUrl;
  bool showLocalImage = false;
  DatabaseReference? itemRef;
  var time = DateTime.now().toString();

  getPic() {
    if (pickedImage != null) {
      return Container(
        height: 250,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: showLocalImage == true
                ? FileImage(pickedImage!) as ImageProvider
                : NetworkImage(
                    itemModel!.itemPic.toString(),
                  ),
          ),
        ),
      );
    } else {
      return const Icon(Icons.add,size: 150,color: Colors.white,);
    }
  }

  SendCharityData() async {
    var detail = detailController.text;
    var itemName = itemNameController.text;

    final modelDetailCar = await ItemModelCharity (
      itemPic: imgUrl,
      date: time,
      detail: detail,
      id: FirebaseAuth.instance.currentUser!.uid,
      username: userModel?.name,
      displayPic: userModel?.image,
      num: phoneModel?.number,
      itemName: itemName,



    );
    final jsonCar = modelDetailCar.toJSON();

    if (user != null) {
      await FirebaseFirestore.instance.collection('charity').doc(time).set(jsonCar);
    }


  }

  getUserDetail() async {
    DatabaseEvent snapshot = await userRef!.once();

    userModel = UserModel.fromMap(
        Map<String, dynamic>.from(snapshot.snapshot.value as Map));

    setState(() {});
  }


//--------------------------Pick Images--------------------------------------//
  pickImageFromCamera() async {
    XFile? file = await ImagePicker().pickImage(source: ImageSource.camera);
    if (file == null) return;

    final tempImg = File(file.path);

    pickedImage = tempImg;
    showLocalImage = true;

    setState(() {
      pickedImage = tempImg;
    });

    ProgressDialog progressDialog = ProgressDialog(
      context,
      title: const Text('Uploading!'),
      message: const Text('Please wait'),
    );

    progressDialog.show();

    //------------------------Uploading Image to FireBase-----------------------------------//

    var fileName = DateTime.now().toString() + '.jpg';

    UploadTask uploadTask =
        FirebaseStorage.instance.ref().child(fileName).putFile(pickedImage!);

    imgUrl = await (await uploadTask).ref.getDownloadURL();
    print(imgUrl.toString());

    //-------------------------update user firestore------------------------//

    if (itemRef != null) {
      FirebaseFirestore.instance
          .collection('laps')
          .doc(time)
          .update(
          {
            'itemPic': imgUrl.toString(),
          }
      );
    }
    progressDialog.dismiss();
  }

  pickImageFromGal() async {
    XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file == null) return;

    final tempImg = File(file.path);

    pickedImage = tempImg;
    showLocalImage = true;

    setState(() {
      pickedImage = tempImg;
    });

    ProgressDialog progressDialog = ProgressDialog(
      context,
      title: const Text('Uploading!'),
      message: const Text('Please wait'),
    );

    progressDialog.show();

    //------------------------Uploading Image to FireBase-----------------------------------//

    var fileName = DateTime.now().toString() + '.jpg';

    UploadTask uploadTask =
        FirebaseStorage.instance.ref().child(fileName).putFile(pickedImage!);

    TaskSnapshot taskSnapshot = await uploadTask;
    imgUrl = await taskSnapshot.ref.getDownloadURL();
    print(imgUrl.toString());

    //-------------------------update user firestore------------------------//

    if (itemRef != null) {
      FirebaseFirestore.instance
          .collection('laps')
          .doc(DateTime.now().toString())
          .update({'itemPic': imgUrl.toString()});
    }

    progressDialog.dismiss();
  }

  //--------------------------//

  //----------------------------------init state-----------------------------------------------//

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
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: heroAddTodo,
          child: Material(
            color: Colors.grey,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (ctx) {
                              return Wrap(
                                children: [
                                  ListTile(
                                    onTap: () {
                                      pickImageFromCamera();
                                      Navigator.of(context).pop();
                                    },
                                    leading: const Icon(Icons.camera_alt),
                                    title: const Text('Camera'),
                                    tileColor: Colors.grey,
                                  ),
                                  ListTile(
                                    onTap: () {
                                      pickImageFromGal();
                                      Navigator.of(context).pop();
                                    },
                                    leading: const Icon(Icons.photo),
                                    title: const Text('Gallery'),
                                    tileColor: Colors.grey,
                                  ),
                                ],
                              );
                            });
                      },
                      child: getPic(),
                    ),


                    const SizedBox(
                      height: 40,
                    ),

                    const Divider(
                      color: Colors.white,
                      thickness: 0.2,
                    ),

                    TextField(
                      controller: itemNameController,
                      decoration: const InputDecoration(
                        hintText: 'Write Item Name',

                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white
                          ),
                        ),

                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white
                          ),
                        ),
                      ),


                      cursorColor: Colors.white,
                      maxLines: 2,
                    ),



                    Container(
                      color: Colors.grey.withOpacity(.2),
                      child: TextField(
                        controller: detailController,
                        decoration: const InputDecoration(
                          hintText: 'Write Detail',


                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white
                            ),
                          ),

                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white
                            ),
                          ),
                        ),



                        cursorColor: Colors.white,
                        maxLines: 6,
                      ),
                    ),


                    TextField(
                      controller: itemPriceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Item Price',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white
                          ),
                        ),

                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white
                          ),
                        ),
                      ),

                      cursorColor: Colors.white,
                      maxLines: 1,
                    ),



                    // DropdownButton(items: const [
                    //   DropdownMenuItem(child: Text('Mobiles')),
                    //   DropdownMenuItem(child: Text('Cars')),
                    //   DropdownMenuItem(child: Text('Houses')),
                    //   DropdownMenuItem(child: Text('Laptops')),
                    //   DropdownMenuItem(child: Text('Furnitures')),
                    //   DropdownMenuItem(child: Text('Charity')),
                    // ],
                    //     value: _dropdownValue,
                    //
                    //
                    //     onChanged: dropdownCallback),

                    const Divider(
                      color: Colors.white,
                      thickness: 0.2,
                    ),
                    TextButton(
                      onPressed: () {
                       var detail = detailController.text;
                       var itemName = itemNameController.text;

                       detail.isEmpty || itemName.isEmpty ? Fluttertoast.showToast(msg: "Please Provide Detail "):

                        SendCharityData();
                        print(itemModel?.num.toString());

                        Navigator.of(context).pop();
                      },
                      child: const Text('Add'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
