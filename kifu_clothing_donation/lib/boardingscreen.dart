
import 'dart:math';

import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:kifu_clothing_donation/Charity/Authentication/loginscreen_charity.dart';
import 'package:kifu_clothing_donation/constants.dart';
import 'package:kifu_clothing_donation/widget/customClipper.dart';

import 'Donor/authentication/Login_Donor.dart';



class boarding extends StatefulWidget {
  @override
  _boardingState createState() => _boardingState();
}

class _boardingState extends State<boarding> {
  final Duration initialDelay = Duration(seconds: 1);
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            overflow: Overflow.visible,
            children: [

              Center(
                  child: Stack(
                    overflow: Overflow.visible,
                    children: [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            DelayedDisplay(
                              delay: initialDelay,
                              child: Text(
                                "Welcome To",
                                style: GoogleFonts.share(

                                  fontSize: 28.0,
                                  color:Color(0xff427BD2)
                                ),
                              ),
                            ),const SizedBox(
                              height: 10.0,
                            ),
                            DelayedDisplay(
                              delay: Duration(seconds:initialDelay.inSeconds + 1),
                              child: Column(
                                children: [
                                  Container(
                                      width: 100, height: 100, child: Image.asset("image/mainlogo.png")),

                                ],
                              ),
                            ),
                            DelayedDisplay(
                              delay: Duration(seconds: initialDelay.inSeconds + 2),
                              child: Text(
                                "Take apart in Clothes Donation",
                                style: GoogleFonts.syne(

                                  fontSize: 16.0,
                                  color: Colors.black38,
                                ),
                              ),
                            ),
                            SizedBox(height:11),
                            DelayedDisplay(
                              delay: Duration(seconds: initialDelay.inSeconds + 2),
                              child: Text(
                                "\"No one has ever become poor by giving\"",
                                style: GoogleFonts.pacifico(

                                  fontSize: 19.0,

                                  color: Colors.black38,
                                ),
                              ),
                            ),
SizedBox(height:80,),
                            DelayedDisplay(
                              delay: Duration(seconds: initialDelay.inSeconds + 4),
                              child: Column(
                                children: [
                                  Text(
                                      "Join As",
                                      style: GoogleFonts.syne(

                                        fontSize: 18.0,
                                        color: Colors.black54,
                                      )),   SizedBox(height:20),
                                  Row(
                                    mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width:120,
                                        height: 35,
                                        decoration: BoxDecoration(
                                            color: primaryColor,
                                            borderRadius: BorderRadius.circular(10)),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context, MaterialPageRoute(builder: (context) =>login_Charity()));
                                          },child:const Center(
                                          child: Text(
                                            "Charity",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        ),
                                      ),
                                      Container(
                                        width:120,
                                        height: 35,
                                        decoration: BoxDecoration(
                                            color: primaryColor,
                                            borderRadius: BorderRadius.circular(10)),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context, MaterialPageRoute(builder: (context) =>LoginScreen ()));
                                          },child:const Center(
                                          child: Text(
                                            "Donor",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),

                          ]
                      ),


                    ],
                  )),



              Positioned(
                  top: -height * .15,
                  right: -MediaQuery
                      .of(context)
                      .size
                      .width * .4,
                  child: Container(
                      child: Transform.rotate(
                        angle: -pi / 3.5,
                        child: ClipPath(
                          clipper: ClipPainter(),
                          child: Container(
                            height: MediaQuery.of(context).size.height * .5,
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [Colors.white,Color(0xff427BD2)])),
                          ),
                        ),
                      )))
            ],
          ),
        ));
  }
}
