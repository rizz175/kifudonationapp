// ignore_for_file: prefer_const_constructors, unnecessary_new, file_names

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kifu_clothing_donation/constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:path/path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';


import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../Model/charitymodel.dart';
import '../../widget/customClipper.dart';
import '../menubar_charity.dart';


class charityregister extends StatefulWidget {
  const charityregister({Key? key}) : super(key: key);

  @override
  _charityregisterState createState() => _charityregisterState();
}

class _charityregisterState extends State<charityregister> {
  final _auth = FirebaseAuth.instance;
  bool toggle = true;
  int x = 0;
  bool status=false;
  // our form key
  final _formKey = GlobalKey<FormState>();
  // editing Controller
  final fullNameEditingController = new TextEditingController();
  final cityNameEditingController = new TextEditingController();
  final phoneEditingController = new TextEditingController();
  final aboutme = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();
  File _pickedImage=File('your initial file');
  String image="";
  bool pro=false;
  String charitytype='';
  Future<void> loadAssets(ImageSource source) async {
    ImagePicker imagePicker = ImagePicker();
    var selected = await imagePicker.getImage(source:source);
    print(selected!.path.toString());

    final bytes = File(selected.path).readAsBytesSync();
    String img64 = base64Encode(bytes);
    image=img64;

    setState(() {
      _pickedImage = File(selected.path);
    });
  }
  @override
  Widget build(BuildContext context) {
    //first name field
    final height = MediaQuery
        .of(context)
        .size
        .height;
    final fullNameField = TextFormField(
        autofocus: false,
        controller: fullNameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("Full Name cannot be Empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid name(Min. 3 Character)");
          }
          return null;
        },
        onSaved: (value) {
          fullNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          icon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Full Name",
        ));
    final cityNameField = TextFormField(
        autofocus: false,
        controller:  cityNameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {

          if (value!.isEmpty) {
            return ("City Name cannot be Empty");
          }

          return null;
        },
        onSaved: (value) {
          cityNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          icon: Icon(Icons.location_on),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "City Name",
        ));
    //second name field
    final phoneField = TextFormField(
        autofocus: false,
        controller: phoneEditingController,
        keyboardType: TextInputType.number,
        validator: (value) {
          final regex = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');


          if (value!.isEmpty) {
            return ("Phone NO cannot be Empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid phone(Min. 10 Character)");
          }
          return null;
        },
        onSaved: (value) {
          phoneEditingController.text= value!;
          x = 0;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          icon: Icon(Icons.phone),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Phone No",
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
          emailEditingController.text = value!;
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
          passwordEditingController.text = value!;
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


    return Scaffold(
      backgroundColor: Colors.white,

      body:ModalProgressHUD(
        inAsyncCall: status,
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
                          "Charity Registration",
                          style: GoogleFonts.share(

                              fontSize: 23.0,
                              letterSpacing: 2,
                              color:primaryColor,
                              fontWeight: FontWeight.bold
                          ),
                        ), SizedBox(
                          height: 25,
                        ),
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 70,
                              backgroundColor:Colors.black12,
                              backgroundImage:FileImage(_pickedImage),

                            ),
                            Positioned(
                              bottom: 10,
                              right: 0,
                              left: 0,
                              child: GestureDetector(
                                  onTap:(){

                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: new Text("Select Option"),
                                            content: new Text("Pickup Image Selection"),
                                            actions: <Widget>[
                                              new FlatButton(
                                                child: new Text("Camera"),
                                                onPressed: () {
                                                  loadAssets(ImageSource.camera);
                                                  Navigator.pop(context);

                                                },
                                              ),
                                              new FlatButton(
                                                child: new Text("Gallery"),
                                                onPressed: () {
                                                  loadAssets(ImageSource.gallery);
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          );});
                                  },
                                  child:Icon(
                                    Icons.add_photo_alternate_rounded,

                                    size: 30,
                                    color:Colors.black,

                                  )
                              ),
                            )
                          ],
                        ), SizedBox(height: 20),
                        Container(
                            margin:EdgeInsets.symmetric(horizontal: 20),
                            child: fullNameField),
                        SizedBox(height: 20),
                        Container(
                            margin:EdgeInsets.symmetric(horizontal: 20),
                            child:  phoneField),

                        SizedBox(height: 20),
                        Container(
                            margin:EdgeInsets.symmetric(horizontal: 20),
                            child:  aboutfield),
                        SizedBox(height: 20),

                        Container(
                            margin:EdgeInsets.symmetric(horizontal: 20),
                            child:  cityNameField),
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

                            signUp( emailEditingController.text.toString(),passwordEditingController.text.toString(),context);

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
                                    colors: [Colors.white, Color(0xff427BD2)])),
                          ),
                        ),
                      ))),

            ],
          ),
        ),
      ),

    );
  }

  void signUp(String email, String password,BuildContext context) async {


    if (_formKey.currentState!.validate()) {
      setState(() {
        status=true;
      });
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {print("object"), uploadImageToFirebase(context)})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
        setState(() {
          status=false;
        });
      });
    }
  }
  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = basename(_pickedImage.path);
    var firebaseStorageRef =
    FirebaseStorage.instance.ref().child('charitypicture/$fileName');
    var uploadTask = firebaseStorageRef.putFile(_pickedImage);
    var taskSnapshot = await uploadTask;
    taskSnapshot.ref.getDownloadURL().then(
          (value) => _postFB(value,context),
    ).onError((error, stackTrace) {
      setState(() {
        status==false;
      });
      print(error.toString());
    });
  }

  void _postFB(path,BuildContext context) async {
    User? user = _auth.currentUser;
    CharityModel userModel = CharityModel();
    userModel.imageFile = path;
    userModel.email = emailEditingController.text;
    userModel.uid = user!.uid;
    userModel.fullName = fullNameEditingController.text;
    userModel.phone = phoneEditingController.text;
    userModel.about=aboutme.text;
    userModel.password = passwordEditingController.text;
    userModel.cityname = cityNameEditingController.text;

    await FirebaseFirestore.instance
        .collection("charity")
        .doc(user.uid)
        .set( userModel.toMap());
    setState(() async {

      status=false;
      Fluttertoast.showToast(msg:"Account Created");
      UserCredential userCredential =await _auth.signInWithEmailAndPassword(
          email:emailEditingController.text,
          password:passwordEditingController.text
      );
      //
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => menubar_charity()));
    });

  }

}
