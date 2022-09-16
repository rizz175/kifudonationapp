// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kifu_clothing_donation/Charity/Authentication/signup_charity.dart';
import 'package:kifu_clothing_donation/Charity/menubar_charity.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../constants.dart';
import '../../widget/customClipper.dart';



class login_Charity extends StatefulWidget {
  const login_Charity({Key? key}) : super(key: key);

  @override
  _login_CharityState createState() => _login_CharityState();
}

class _login_CharityState extends State<login_Charity> {
  // form key
  final _formKey = GlobalKey<FormState>();

  // editing controller
  String email='';
  String password='';
  bool status = false;
  String isC = "Donors";
  // firebase
  final _auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .of(context)
        .size
        .height;
    //email field
    final emailField = TextFormField(
        autofocus: false,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your Email");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid email");
          }
          return null;
        },
        onChanged: (value) {
          email = value;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.indigo),
          ),    focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color: Colors.indigo)),
          prefixIcon: Icon(Icons.mail,color:Colors.indigo),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ));

    //password field
    final passwordField = TextFormField(
        autofocus: false,
        obscureText: true,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Password is required for login");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Password(Min. 6 Character)");
          }
        },
        onChanged: (value) {
          password = value;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.indigo),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: Colors.indigo)),
          prefixIcon: Icon(Icons.vpn_key,color:Colors.indigo,),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(

            borderRadius: BorderRadius.circular(6),

          ),
        ));
    return Scaffold(

      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: status,
        child: SingleChildScrollView(
          child:Stack(
            children: [
              Container(

                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(36.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 115,
                        ),
                        SizedBox(
                            height: 100,
                            child: Image.asset(
                              "image/mainlogo.png",
                              fit: BoxFit.contain,
                              width:100,height:100,
                            )),
                        SizedBox(
                          height: 35,
                        ),
                        Text(
                          "Charity Login",
                          style: GoogleFonts.share(

                              fontSize: 23.0,
                              letterSpacing: 2,
                              color: Colors.indigo,
                              fontWeight: FontWeight.bold
                          ),
                        ), SizedBox(
                          height: 15,
                        ),
                        emailField,
                        SizedBox(height: 15),
                        passwordField,
                        // SizedBox(height: 35),
                        // loginButton,
                        SizedBox(height: 15),
                        Container(

                          width:MediaQuery.of(context).size.width-20 ,
                          child: ElevatedButton(onPressed: (){
                            re();

                          }, child:Text(
                              "LOGIN"
                          ),    style: ElevatedButton.styleFrom(
                              primary:primaryColor,
                              padding: EdgeInsets.symmetric(horizontal:0, vertical: 13),
                              textStyle: TextStyle(
                                fontSize: 16,
                              )),
                          ),
                        ),  // loginButton,
                        SizedBox(height: 15),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Don't have an account? "),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                             charityregister()));
                                },
                                child: Text(
                                  " SignUp",
                                  style: TextStyle(
                                      color:Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              )
                            ])
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                  top:60,
                  left:10,
                  child:InkWell(
                      onTap:(){
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back,color: Colors.indigo,size:24,))),
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
                                    colors: [Colors.white,  Color(0xff427BD2)])),
                          ),
                        ),
                      )))
            ],
          ),
        ),
      ),


    );
  }

  void re() {
    signIn(email, password);
  }

  // login function
  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate() && email!=''  && password!='')


    {
      setState(() {
        status=true;
      });
      // FirebaseFirestore.instance.collection('Agent').doc(_email);

      try{
        UserCredential userCredential =await _auth.signInWithEmailAndPassword(
            email:email,
            password:password
        );
        //
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => menubar_charity()));
        setState(() {
          status=false;
        });

      } on FirebaseAuthException catch (e) {
        setState(() {
          status=false;
        });
        if (e.code == 'user-not-found') {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: new Text("Alert"),
                  content: new Text("No user found for that email"),
                  actions: <Widget>[
                    new FlatButton(
                      child: new Text("OK"),
                      onPressed: () {

                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );});
        }
        else if (e.code == 'wrong-password') {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Alert"),
                  content: const Text("Wrong Password"),
                  actions: <Widget>[
                    new FlatButton(
                      child: new Text("OK"),
                      onPressed: () {

                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );});
        }
      } catch (e) {
        print(e);
      }


    }
    else{
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text("Alert"),
              content: new Text("Please Enter Values"),
              actions: <Widget>[
                new FlatButton(
                  child: new Text("OK"),
                  onPressed: () {

                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    }







  }}
