// ignore_for_file: prefer_const_constructors, unnecessary_new, file_names

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kifu_clothing_donation/constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../Model/user_model.dart';
import '../../widget/customClipper.dart';
import '../menubar.dart';


class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  bool toggle = true;
  int x = 0;
  bool status=false;
  // our form key
  final _formKey = GlobalKey<FormState>();
  // editing Controller
  final firstNameEditingController = new TextEditingController();
  final secondNameEditingController = new TextEditingController();
  final aboutme = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    //first name field
    final height = MediaQuery
        .of(context)
        .size
        .height;
    final firstNameField = TextFormField(
        autofocus: false,
        controller: firstNameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("First Name cannot be Empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid name(Min. 3 Character)");
          }
          return null;
        },
        onSaved: (value) {
          firstNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          icon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "First Name",
        ));

    //second name field
    final secondNameField = TextFormField(
        autofocus: false,
        controller: secondNameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Second Name cannot be Empty");
          }
          return null;
        },
        onSaved: (value) {
          secondNameEditingController.text = value!;
          x = 0;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          icon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Second Name",
        ));
    final aboutfield = TextFormField(
        autofocus: false,
        controller: aboutme,
        keyboardType: TextInputType.streetAddress,
        maxLines:null,

        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          icon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "About me",
        ));
    //email field
    final emailField = TextFormField(
        autofocus: false,
        controller: emailEditingController,
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
        onSaved: (value) {
          firstNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          icon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
        ));

    //password field
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordEditingController,
        obscureText: toggle,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Password is required for login");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Password(Min. 6 Character)");
          }
        },
        onSaved: (value) {
          firstNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          suffixIcon: IconButton(
              icon: Icon(toggle ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  toggle = !toggle;
                });
              }),
          icon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
        ));

    //confirm password field
    final confirmPasswordField = TextFormField(
        autofocus: false,
        controller: confirmPasswordEditingController,
        obscureText: toggle,
        validator: (value) {
          if (confirmPasswordEditingController.text !=
              passwordEditingController.text) {
            return "Password don't match";
          }
          return null;
        },
        onSaved: (value) {
          confirmPasswordEditingController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          suffixIcon: IconButton(
              icon: Icon(toggle ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  toggle = !toggle;
                });
              }),
          icon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Confirm Password",
        ));
    //signup button

    MainAxisAlignment.start;
    final signUpButton = Material(
      elevation: 9,
      shadowColor: Colors.black,
      borderRadius: BorderRadius.circular(60),
      color: Color(0xff514644),
      child: IconButton(
        highlightColor: Colors.black,
        alignment: Alignment.bottomRight,
        icon: Icon(
          Icons.forward_sharp,
        ),
        iconSize: 40,
        color: Colors.white,
        // splashColor: Colors,
        onPressed: () {
          signUp(emailEditingController.text, passwordEditingController.text);
        },
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,

      body:ModalProgressHUD(
        inAsyncCall:status,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
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
                        Text(
                          "Donor Registration",
                          style: GoogleFonts.share(

                              fontSize: 23.0,
                              letterSpacing: 2,
                              color: primaryColor,
                              fontWeight: FontWeight.bold
                          ),
                        ), SizedBox(
                          height: 25,
                        ),
                        Container(
                            margin:EdgeInsets.symmetric(horizontal: 20),
                            child: firstNameField),
                        SizedBox(height: 20),
                        Container(
                            margin:EdgeInsets.symmetric(horizontal: 20),
                            child:  secondNameField),
                        SizedBox(height: 20),
                        Container(
                            margin:EdgeInsets.symmetric(horizontal: 20),
                            child:  aboutfield),
                        SizedBox(height: 20),
                        Container(
                            margin:EdgeInsets.symmetric(horizontal: 20),
                            child: emailField),
                        SizedBox(height: 20),
                        Container(
                            margin:EdgeInsets.symmetric(horizontal: 20),
                            child: passwordField),
                        SizedBox(height: 20),
                        Container(

                            margin:EdgeInsets.symmetric(horizontal: 20),
                            child: confirmPasswordField),
                        SizedBox(
                          height:30,

                        ),
                        Container(

                          width:MediaQuery.of(context).size.width-40 ,
                          child: ElevatedButton(onPressed: (){

                            signUp( emailEditingController.text.toString(),passwordEditingController.text.toString());

                          }, child:Text(
                              "Resgister"
                          ),    style: ElevatedButton.styleFrom(
                              primary: primaryColor,
                              padding: EdgeInsets.symmetric(horizontal:0, vertical: 13),
                              textStyle: TextStyle(
                                fontSize: 16,
                              )),
                          ),
                        ),
                        SizedBox(
                          height:30,

                        ),
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
                                    colors: [Colors.white,Color(0xff427BD2)])),
                          ),
                        ),
                      ))),

            ],
          ),
        ),
      ),

    );
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        status=true;
      });
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {print("object"), postDetailsToFirestore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
        setState(() {
          status=false;
        });
      });
    }
  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = firstNameEditingController.text;
    userModel.secondName = secondNameEditingController.text;
    userModel.about=aboutme.text;
    userModel.password = passwordEditingController.text;
    // userModel.isCharity = "Donors";
    // userModel.imagePath = "'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=333&q=80'";
    await firebaseFirestore
        .collection("donors")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");
    setState(() async {
      UserCredential userCredential =await _auth.signInWithEmailAndPassword(
          email:emailEditingController.text,
          password:passwordEditingController.text
      );
      //

      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => menubar_donor()));
      setState(() {
        status=false;
      });
    });
  }
}
