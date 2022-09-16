import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kifu_clothing_donation/constants.dart';

import 'detail.dart';
class home_charity extends StatefulWidget {
  const home_charity({Key? key}) : super(key: key);

  @override
  _home_charityState createState() => _home_charityState();
}

class _home_charityState extends State<home_charity> {

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;

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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              padding: const EdgeInsets.only(top: 50.0,bottom:30,left:10,right:10),
              width:MediaQuery.of(context).size.width,

              decoration:BoxDecoration(
                  color:primaryColor
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width:MediaQuery.of(context).size.width*.9,
                    child: Row(
                      children: [
                        Container(
                            width:60,
                            height:60,
                            child: Image.asset("image/mainlogo.png")),
                        Text("Welcome $fname,",style:headingstyle,)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:58.0),
                    child: Text(
                      "\"Your old clothes can be someone else dress\"",
                      style: GoogleFonts.syne(

                        fontSize: 16.0,
                        color: Colors.white70,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(

              child:Padding(
                padding: const EdgeInsets.only(top: 0.0, left: 10, right: 10),
                child:




                StreamBuilder<QuerySnapshot>(
                    stream: db.collection(auth.currentUser!.email.toString()).snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(

                            itemCount: snapshot.data?.docs.length,
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              DocumentSnapshot ds = snapshot.data!.docs[index];
                              return GestureDetector(
                                onTap:(){
                                  log("heeee");


                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => detail(ds)));

                                },
                                child: Container(
                                  padding:EdgeInsets.all(10),
                                  margin:EdgeInsets.only(bottom:10),
                                  width:MediaQuery.of(context).size.width*0.9,
                                  decoration: BoxDecoration(
                                      border:Border.all(color:Colors.black38),
                                      color:  Color(0xfff6f8f8),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: ListTile(
                                    leading:CircleAvatar(
                                      child:Image.asset("image/mainlogo.png"),

                                    ),
                                    title:Text(ds['name']),
                                    subtitle:Text("Pickup "+ds['status'],style:TextStyle(color:ds["status"]=="Pending"?Colors.red:Colors.green),),
                                    trailing:Text(ds['date']),

                                  ),
                                ),
                              );
                            });
                      } else if (snapshot.hasError) {
                        return Center(child: Padding(
                          padding: const EdgeInsets.all(58.0),
                          child: CircularProgressIndicator(),
                        ));
                      } else {
                        return Center(child: Padding(
                          padding: const EdgeInsets.all(58.0),
                          child: CircularProgressIndicator(),
                        ));
                      }
                    }),
              ),
            )

          ],
        ),
      ),
    );
  }
}
