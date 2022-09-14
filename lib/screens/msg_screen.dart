import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.9),
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Messages',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
      ),
      drawer: Drawer(),
    );
  }
}
