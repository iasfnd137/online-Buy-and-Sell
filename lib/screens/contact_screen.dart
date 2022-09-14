import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  var mobileNum ="+923020908518";
  _launchPhoneURL(String phoneNumber) async {
    String url = 'tel:' + phoneNumber;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  openwhatsapp() async{
    var whatsappURl_android = "whatsapp://send?phone="+mobileNum+"&text=hello";
    var whatappURL_ios ="https://wa.me/$mobileNum?text=${Uri.parse("hello")}";
    if(Platform.isIOS){
      // for iOS phone only
      if( await canLaunch(whatappURL_ios)){
        await launch(whatappURL_ios, forceSafariVC: false);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: new Text("whatsapp no installed")));
      }

    }else{
      // android , web
      if( await canLaunch(whatsappURl_android)){
        await launch(whatsappURl_android);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: new Text("whatsapp no installed")));

      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                minWidth: double.infinity,
                onPressed: (){
                  openwhatsapp();
                },
                color: Colors.green,
                shape: StadiumBorder(),
                child: const Text('WhatsApp'),
              ),
              MaterialButton(
                minWidth: double.infinity,
                onPressed: (){
                  _launchPhoneURL(mobileNum);
                },
                color: Colors.greenAccent,
                shape: StadiumBorder(),
                child: const Text('Call'),
              ),
              MaterialButton(
                minWidth: double.infinity,
                onPressed: (){},
                color: Colors.blue,
                shape: StadiumBorder(),
                child: const Text('Sms'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
