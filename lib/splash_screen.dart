import 'package:flutter/material.dart';

//-----------------------------------
//NOT IMPLEMENTED
//-----------------------------------
class SplashScreen extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Image.asset('assets/images/loading.gif'),
            alignment: Alignment.center,
            padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
          ),
        ],
      ),
    );
  }

}