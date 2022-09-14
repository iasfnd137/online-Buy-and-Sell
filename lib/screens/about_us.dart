import 'package:flutter/material.dart';
import 'package:olbs_final_project/widgets/drawer.dart';
class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.withOpacity(0.7),
        centerTitle: true,
        title: Text('About'),),
      drawer: DrawerW(),

    );
  }
}
