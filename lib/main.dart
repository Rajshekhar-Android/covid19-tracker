import 'dart:async';

import 'package:covid_update/home.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Go Corona',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: SplashScree(),
    );
  }
}

class SplashScree extends StatefulWidget   {

  @override
  _SplashScreeState createState() => _SplashScreeState();
}

class _SplashScreeState extends State<SplashScree>{
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Home(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
         image : DecorationImage(
           fit: BoxFit.cover,
           image: AssetImage("assets/stayhome.png"),
         ),
        ),
      ),
    );
  }
}
