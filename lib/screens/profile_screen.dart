import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ndialog/ndialog.dart';
import '../models/number_model.dart';
import '../models/olbs_model.dart';
import '../widgets/drawer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  String netImage =
      'https://i.pinimg.com/564x/ca/52/e6/ca52e6e168595f767c2121a68cc227b0.jpg';

  User? user;
  DatabaseReference? userRef;
  UserModel? userModel;
  DatabaseReference? numRef;
  PhoneModel? phoneModel;

  File? pickedImage;
  bool showLocalImage = false;


  //---------------------------------------------------------//

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


  getNumber() {
    if (phoneModel?.number != null) {
      return Text(
        '  ${phoneModel?.number}   ',
        style: const TextStyle(
          color: Colors.blueGrey,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      );
    } else {
      return const Text(
        '  No Data  ',
        style: TextStyle(
          color: Colors.blueGrey,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      );
    }
  }

  pickImageFromCam() async {
    XFile? file = await ImagePicker().pickImage(source: ImageSource.camera);
    if (file == null) return;

    final tempImg = File(file.path);

    pickedImage = tempImg;
    showLocalImage = true;

    setState(() {});

    ProgressDialog progressDialog = ProgressDialog(
      context,
      title: const Text('Uploading!'),
      message: const Text('Please wait'),
    );

    progressDialog.show();

    //------------------------Uploading Image to FireBase-----------------------------------//

    var fileName = userModel!.email + '.jpg';

    UploadTask uploadTask =
    FirebaseStorage.instance.ref().child(fileName).putFile(pickedImage!);

    TaskSnapshot taskSnapshot = await uploadTask;
    String imageUrl = await taskSnapshot.ref.getDownloadURL();
    print(imageUrl);

    //-------------------------update user real time database------------------------//

    if (userRef != null) {
      userRef!.update({'image': imageUrl});
    }
    progressDialog.dismiss();
  }

  pickImageFromDevice() async {
    XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file == null) return;

    final tempImg = File(file.path);

    pickedImage = tempImg;
    showLocalImage = true;

    setState(() {});

    ProgressDialog progressDialog = ProgressDialog(
      context,
      title: const Text('Uploading!'),
      message: const Text('Please wait'),
    );

    progressDialog.show();

    //------------------------Uploading Image to FireBase-----------------------------------//

    var fileName = userModel!.email + '.jpg';

    UploadTask uploadTask =
        FirebaseStorage.instance.ref().child(fileName).putFile(pickedImage!);

    TaskSnapshot taskSnapshot = await uploadTask;
    String imageUrl = await taskSnapshot.ref.getDownloadURL();
    print(imageUrl);

    //-------------------------update user real time database------------------------//

    if (userRef != null) {
      userRef!.update({'image': imageUrl});
    }
    progressDialog.dismiss();
  }



  //-----------------------------For User Data--------------------------------------//



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

//-------------------------------------------------------------------//

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerW(),
      backgroundColor: Colors.grey.withOpacity(.2),
      appBar: AppBar(
        backgroundColor: Colors.grey.withOpacity(.7),
        title: const Text(
          'Profile',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: userModel == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Stack(children: [
                    Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 93,
                        backgroundColor: Colors.black,
                        child: ClipOval(
                          child: SizedBox(
                              width: 180,
                              height: 180,
                              child: CircleAvatar(
                                backgroundColor: Colors.white10,
                                backgroundImage: showLocalImage == true
                                    ? FileImage(pickedImage!) as ImageProvider
                                    : userModel?.image == null
                                        ? NetworkImage(netImage)
                                        : NetworkImage(
                                            userModel!.image.toString()),
                              )),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 20,
                      right: 10,
                      top: 160,
                      bottom: 0,
                      child: IconButton(
                          highlightColor: Colors.blue,
                          color: Colors.white,
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (ctx) {
                                  return Wrap(
                                    children: [
                                      ListTile(
                                        onTap: () {
                                          pickImageFromCam();
                                          Navigator.of(context).pop();
                                        },
                                        leading: const Icon(Icons.camera_alt),
                                        title: const Text('Camera'),
                                        tileColor: Colors.grey,
                                      ),
                                      ListTile(
                                        onTap: () {
                                          pickImageFromDevice();
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
                          icon: const Icon(
                            Icons.camera_alt,
                            size: 40,
                          )),
                    )
                  ]),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                        tileColor: Colors.black,
                        textColor: Colors.white,
                        leading: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ),
                        title: const Text(
                          'Name',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          '${userModel!.name}',
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Column(
                                      children: [
                                        TextField(
                                          controller: nameController,
                                          decoration: InputDecoration(
                                              hintText: 'Enter Your New Name'),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            var name = nameController.text;
                                            User? user = FirebaseAuth
                                                .instance.currentUser;

                                            if (user != null) {
                                              DatabaseReference update =
                                                  FirebaseDatabase.instance
                                                      .ref()
                                                      .child('users')
                                                      .child(user.uid);
                                              update.update({
                                                'name': name,
                                              });
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                      MaterialPageRoute(
                                                          builder: (ctx) {
                                                return const ProfileScreen();
                                              }));
                                            }
                                          },
                                          child: const Text('Update'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                        tileColor: Colors.black,
                        textColor: Colors.white,
                        leading: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ),
                        title: const Text(
                          'Phone Number',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: getNumber(),
                        trailing: IconButton(
                            onPressed: () {
                              showDialog(
                                // barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Column(
                                      children: [
                                        TextField(
                                          controller: phoneController,
                                          maxLength: 11,
                                          decoration: InputDecoration(
                                              counterText: '',
                                              hintText: 'Enter Your Number'),
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            var number = phoneController.text;

                                            FirebaseDatabase.instance
                                                .ref()
                                                .child('detail')
                                                .child(user!.uid)
                                                .set({'number': number});

                                            Navigator.of(context)
                                                .pushReplacement(
                                                    MaterialPageRoute(
                                                        builder: (ctx) {
                                              return const ProfileScreen();
                                            }));
                                          },
                                          child: const Text('Update'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                        tileColor: Colors.black,
                        textColor: Colors.white,
                        leading: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ),
                        title: const Text(
                          'Email',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          userModel!.email,
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                        tileColor: Colors.black,
                        textColor: Colors.white,
                        leading: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ),
                        title: const Text(
                          'CNIC',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          userModel!.cnic.toString(),
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
