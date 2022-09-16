// @dart=2.9

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';




import 'package:google_fonts/google_fonts.dart';

import 'boardingscreen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title:"Kifu",
      home:MyApp(),
      theme: ThemeData(
      //2
      primaryColor: Color(0xff427BD2),

    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Montserrat', //3
    visualDensity: VisualDensity.adaptivePlatformDensity,

    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary:Color(0xff427BD2), //change background color of button
          onPrimary: Colors.white, //change text color of button
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        )),
  ),


  ));
}

class MyApp extends StatefulWidget {


  @override
  _MAppState createState() => _MAppState();
}

class _MAppState extends State<MyApp> {
  @override
  void initState() {
    startSplashScreen();


    super.initState();


  }
  startSplashScreen() {
    var duration = const Duration(seconds: 3);
    return Timer(duration, () {
      Navigator.pushReplacement(
        context,
        new MaterialPageRoute(builder: (context) =>  boarding()),
      );

    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,

      body:Center(child:Column(
        mainAxisAlignment:MainAxisAlignment.center,
        children: [

          Container(

              width:150,height:150,

              child:Image.asset("image/mainlogo.png")



          ),
          SizedBox(height:40,),

          Container(

              width:20,height:20,

              child:Image.asset("image/load.gif")



          ),



        ],
      )







      ),

    );

  }
}

