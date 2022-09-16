import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
class detail extends StatefulWidget {
var ds;

detail(this.ds);

@override
  _detailState createState() => _detailState();
}

class _detailState extends State<detail> {

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
    return Scaffold(
      body:SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 50.0,bottom:20,left:10,right:10),
              width:MediaQuery.of(context).size.width,

              decoration:BoxDecoration(
                  color:primaryColor
              ),
              child: Container(
                width:MediaQuery.of(context).size.width*.6,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap:(){
                        Navigator.of(context).pop();
                      },
                      child: Container(
                          width:30,
                          height:30,
                          child: Icon(Icons.arrow_back,color:Colors.white,)),
                    ),
                    Text("Pickup Detail",style:headingstyle,),


GestureDetector(
  onTap:(){
    showDialog( context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title:const Text('Status'),
          children: <Widget>[
            Container(
              color:primaryColor,
              margin:EdgeInsets.all(20),
              child: SimpleDialogOption(
                onPressed: () {

                  db.collection(widget.ds['name']).doc(widget.ds['id']).update({
                    'status':"Done"
                  });
                  db.collection(auth.currentUser!.email.toString()).doc(widget.ds.id).update({
                    'status':"Done"
                  });
                  Navigator.pop(context);
                },
                child:const Text('Pickup Done',style:TextStyle(color:Colors.white),),

              ),
            ),
            Container(
              color:Colors.red,
              margin:EdgeInsets.symmetric(horizontal: 20),
              child: SimpleDialogOption(
                onPressed: () {

                  db.collection(widget.ds['name']).doc(widget.ds['id']).update({
                    'status':"Pending"
                  });
                  db.collection(auth.currentUser!.email.toString()).doc(widget.ds.id).update({
                    'status':"Pending"
                  });
                  Navigator.pop(context);
                },
                child:const Text('Pickup Pending',style:TextStyle(color:Colors.white),),

              ),
            ),
          ],
        );
      },);

  },
  child:Container(
      color:Colors.red,
      padding: EdgeInsets.all(10),
      child: Text("Status",style:TextStyle(color:Colors.white),)) ,
)

                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Container(
                    height:200,
                    width:MediaQuery.of(context).size.width,

                    child:ListView.builder(
                        itemCount:widget.ds["images"].length,
                        shrinkWrap: true,scrollDirection:Axis.horizontal,
                        itemBuilder:(BuildContext context,int i)
                    {
                      return Container(
                        width:MediaQuery.of(context).size.width*0.9,
                        margin:EdgeInsets.all(10),

                        child:FadeInImage(
                          height: 150,
                          fit:BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          fadeInDuration: const Duration(milliseconds: 500),
                          fadeInCurve: Curves.easeInExpo,
                          fadeOutCurve: Curves.easeOutExpo,
                          placeholder: AssetImage("image/addi.jpeg"),
                          image: NetworkImage(widget.ds["images"][i]
                          ),
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Container(child: Image.asset("image/addi.jpeg"));
                          },

                        ),
                        );
                    }
                    ),

                  ),
                  SizedBox(height:30,),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 17),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Text(
                          "Description",
                          style: TextStyle(
                            fontSize: 15,


                          ), ),
                        Text(
                          "${widget.ds['description']}",
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
                          "Status",
                          style: TextStyle(
                            fontSize: 15,


                          ), ),
                        Text(
                          "${widget.ds["status"]}",
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
                          "Donated By",
                          style: TextStyle(
                            fontSize: 15,


                          ), ),
                        Text(
                          "${widget.ds['name']}",
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
                          "Address",
                          style: TextStyle(
                            fontSize: 15,
                          ), ),
                        Text(
                          "${widget.ds['address']}",
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
                          "Phone",
                          style: TextStyle(
                            fontSize: 15,
                          ), ),
                        Text(
                          "${widget.ds['phone']}",
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
                          "Date",
                          style: TextStyle(
                            fontSize: 15,
                          ), ),
                        Text(
                          "${widget.ds['date']}",
                          style: TextStyle(
                            fontSize: 15,

                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
