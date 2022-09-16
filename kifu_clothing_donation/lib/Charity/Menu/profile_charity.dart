import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kifu_clothing_donation/Charity/Authentication/loginscreen_charity.dart';
import 'package:kifu_clothing_donation/Donor/authentication/Login_Donor.dart';

import '../../constants.dart';

class profile_charity extends StatefulWidget {
  const profile_charity({Key? key}) : super(key: key);

  @override
  _profile_charityState createState() => _profile_charityState();
}

class _profile_charityState extends State<profile_charity> {

  var db=FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  var fname="";

  var location="";
  var email="";
  var about="";
  var image="";
  var phone="";

  @override
  void initState() {
    getuserdata();

    super.initState();
  }
  Future<void> getuserdata()
  async {
    final User? user = auth.currentUser;
    final uid = user?.uid;

    var snapshot = await FirebaseFirestore.instance
        .collection("charity")
        .doc(uid)
        .get();
    Map<String, dynamic>? data = snapshot.data();

    setState(() {

      fname= data!['fullName'];
      email = data!['email'];
      location= data!['cityname'];
      about = data!['about'];
      image = data!['imageFile'];
      phone=data!['phone'];
    });


  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            child:Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "My Profile",
                          style: headingstyle2, ),

                        // GestureDetector(
                        //   onTap:(){
                        //     Navigator.pop(context);
                        //   },
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(8.0),
                        //     child: Icon(FontAwesomeIcons.userEdit,color: Colors.white,size: 20,),
                        //   ),
                        // )
                      ],
                    ),
                    SizedBox(height:20),
                    new Container(
                        width: MediaQuery.of(context).size.width,
                        height:150,
                        child:FadeInImage(
                          height: 150,
                          fit:BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          fadeInDuration: const Duration(milliseconds: 500),
                          fadeInCurve: Curves.easeInExpo,
                          fadeOutCurve: Curves.easeOutExpo,
                          placeholder: AssetImage("image/addi.jpeg"),
                          image: NetworkImage(image
                          ),
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Container(child: Image.asset("image/addi.jpeg"));
                          },

                    )),
                    SizedBox(height:30,),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 17),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Text(
                            "Name",
                            style: TextStyle(
                              fontSize: 15,


                            ), ),
                          Text(
                            "$fname",
                            style: TextStyle(
                              fontSize: 15,

                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width:double.infinity,
                      height:1,
                      color:Colors.black12,
                    ),   Padding(
                      padding: const EdgeInsets.symmetric(vertical: 17),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Text(
                            "City",
                            style: TextStyle(
                              fontSize: 15,


                            ), ),
                          Text(
                            "$location",
                            style: TextStyle(
                              fontSize: 15,

                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width:double.infinity,
                      height:1,
                      color:Colors.black12,
                    ),
                    SizedBox(height:10,),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 17),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Text(
                            "About",
                            style: TextStyle(
                              fontSize: 15,


                            ), ),
                          Text(
                            "$about",
                            style: TextStyle(
                              fontSize: 15,

                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width:double.infinity,
                      height:1,
                      color:Colors.black12,
                    ),
                    Container(
                      width:double.infinity,
                      height:1,
                      color:Colors.black12,
                    ),
                    SizedBox(height:10,),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 17),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Text(
                            "Email",
                            style: TextStyle(
                              fontSize: 15,
                            ), ),
                          Text(
                            "$email",
                            style: TextStyle(
                              fontSize: 15,

                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width:double.infinity,
                      height:1,
                      color:Colors.black12,
                    ),
                    SizedBox(height:30,),
                    Container(
                        margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: ElevatedButton(
                          child: Text('Sign Out'),
                          onPressed: () async {
                            auth.signOut();

                            Navigator.pushReplacement(
                              context,
                              new MaterialPageRoute(builder: (context) => login_Charity()),
                            );

                          },
                          onLongPress: () {
                            print('Long press');
                          },

                        ))

                  ],

                ),
              ),
            )));
  }
}
