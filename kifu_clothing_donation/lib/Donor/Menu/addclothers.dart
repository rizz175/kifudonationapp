import 'dart:core';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:kifu_clothing_donation/Model/charity_model.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:path/path.dart';

import '../../constants.dart';
class addclothes extends StatefulWidget {
  const addclothes({Key? key}) : super(key: key);

  @override
  _addclothesState createState() => _addclothesState();
}

class _addclothesState extends State<addclothes> {
  List<File> imageslist = [];
  bool imagelistbox = false;
  bool imageaddbox = true;
  String? category;
  String? charityemail;
  String? number;
  String? location;
  String? description;
  String? latitude ;
  String? date="";
  String? phone;
  var db=FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  var fname="";

  var lname="";
  var email="";
  var about="";
  var id="";
  @override
  void initState() {
    getuserdata();
    getcharity();

    super.initState();
  }
  Future<void> getuserdata()
  async {

    final User? user = auth.currentUser;
    final uid = user?.uid;
    id=uid!;
    var snapshot = await FirebaseFirestore.instance
        .collection("donors")
        .doc(uid)
        .get();
    Map<String, dynamic>? data = snapshot.data();

    setState(() {

      fname= data!['firstName'];
      email = data!['email'];
      lname = data!['secondName'];
      about = data!['about'];
    });


  }
  bool showSpinner = false;
  DateTime selectedDate = DateTime.now();
 List charitylist=[];
 List charityemaillist=[];
  String? address ;
  final ImagePicker _picker = ImagePicker();
  optionaldialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actionsPadding: EdgeInsets.symmetric(horizontal: 10),
            insetPadding: EdgeInsets.symmetric(horizontal: 0),
            title: Text("Select Option"),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _getFromGallery();
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white54,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 1,
                              blurRadius: 1,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.add_photo_alternate_outlined,
                                color: Colors.black54,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Gallery",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        _getFromCamera();
                        Navigator.of(context).pop();
                      },
                      child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white54,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                spreadRadius: 1,
                                blurRadius: 1,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.camera_alt,
                                  color: Colors.black54,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Camera",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black54),
                                ),
                              ],
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white54,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                spreadRadius: 1,
                                blurRadius: 1,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.clear,
                                  color: Colors.black54,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Cancel",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black54),
                                ),
                              ],
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 16,
                    )
                  ],
                ),
              )
            ],
          );
        });
  }
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        var outputFormat = DateFormat('MM/dd/yyyy');

        date=outputFormat.format(selectedDate);
      });
    }
  }
  Future<void> getcharity() async {
    final User? user = auth.currentUser;
    charityemaillist.clear();
    charitylist.clear();

    var snapshot =
    await db.collection("charity").get();


    for (var queryDocumentSnapshot in snapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      var email = data['email'];
      var name= data['fullName'];
      setState(() {
        charityemaillist.add(email);
        charitylist.add(name);
      });


    }
  }
  File? imageFile;

  /// Get from gallery
  _getFromGallery() async {
    XFile? pickedFile = (await _picker.pickImage(
      source: ImageSource.gallery,
    ));

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        imagelistbox = true;
        imageaddbox = false;
        imageslist.add(imageFile!);
      });
    }
  }
  _getFromCamera() async {
    XFile? pickedFile = (await _picker.pickImage(
      source: ImageSource.camera,
    ));
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        imagelistbox = true;
        imageaddbox = false;
        imageslist.add(imageFile!);
      });
    }
  }
  Future<void> saveImages(List<File> _images, DocumentReference ref,BuildContext context) async {
    for(int i=0;i<_images.length;i++)
    {
      String imageURL = await uploadFile(_images[i]);
      ref.update({
        "images": FieldValue.arrayUnion([imageURL])
      });
      if(i==_images.length-1)
      {
        setState(() {
          showSpinner=false;
          Fluttertoast.showToast(
              msg: "Pickup request send",  // message
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor:Colors.white,
              textColor:Colors.black54,// length
              gravity: ToastGravity.SNACKBAR,    // location
              timeInSecForIosWeb: 1               // duration
          );
          Navigator.of(context).pop();
        });
      }
    }


  }
  Future<String> uploadFile(File _image) async {
    Reference storageReference =
    FirebaseStorage.instance.ref().child('images/${basename(_image.path)}');

    // UploadTask uploadTask = storageReference.putFile(_image);
    // await uploadTask.whenComplete(() {
    //   url = storageReference.getDownloadURL().toString();
    //   log(url);
    // }).catchError((onError) {
    //   print(onError);
    //   log(onError);
    // });

    //Upload the file to firebase
    UploadTask uploadTask = storageReference.putFile(_image);

    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(()
    {

    }).catchError((onError) {
      setState(() {
        showSpinner=false;
      });
      print(onError);
      Fluttertoast.showToast(msg: onError);

    });

    String url = await taskSnapshot.ref.getDownloadURL();
    return url;
    // Waits till the file is uploaded then stores the download url

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:ModalProgressHUD(
        inAsyncCall:showSpinner,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                      Text("Donate Clothes",style:headingstyle,)
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:20.0),
                child: Column(
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children: [

                    Container(
                      margin: EdgeInsets.only(top: 15),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Charites",
                            ),
                          ),
                          Container(
                              height: 55,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                border:Border.all(color:Colors.black),
                                  color:  Color(0xfff6f8f8),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    focusColor: Colors.white,

                                    //elevation: 5,
                                    style: TextStyle(color: Colors.black),
                                    iconEnabledColor: Colors.black,
                                    items:charitylist.map(
                                          (val) {
                                        return DropdownMenuItem<String>(
                                          value: val,
                                          child: Text(val),
                                        );
                                      },
                                    ).toList(),
                                    hint: category == null
                                        ? Text(
                                      "   Select Charity",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    )
                                        : Text(
                                      "  $category",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                    onChanged: (String? value) {
                                      // initialvalue=value!;
                                      setState(() {
                                        category = value;
                                        charityemail=charityemaillist[(charitylist.indexOf(category))];
                                    log(charityemail.toString());

                                      });
                                    },
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Number of items",

                            ),
                          ),
                          TextField(
                            onChanged: (v) {
                              number = v;
                            },
                            maxLines: null,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(

                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(5.0),
                                  ),
                                ),
                                filled: true,
                                hintStyle: new TextStyle(color: Colors.grey[600]),
                                hintText: "1/2/3..",
                                fillColor: Color(0xfff6f8f8)),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Description",
                            ),
                          ),
                          TextField(
                            minLines: 5,
                            onChanged: (v) {
                              description = v;
                            },
                            maxLines: null,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(5.0),
                                  ),
                                ),
                                filled: true,
                                hintStyle: new TextStyle(color: Colors.grey[600]),
                                hintText: "2-Shirts, 1 Saree",
                                fillColor: Color(0xfff6f8f8)),

                          ),

                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Pickup Address",

                            ),
                          ),
                          TextField(
                            onChanged: (v) {
                              address = v;
                            },
                            maxLines: null,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(5.0),
                                  ),
                                ),
                                filled: true,
                                hintStyle: new TextStyle(color: Colors.grey[600]),
                                hintText: "abcd..",
                                fillColor: Color(0xfff6f8f8)),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Phone No.",

                            ),
                          ),
                          TextField(
                            onChanged: (v) {
                              phone = v;
                            },
                            maxLines: null,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(5.0),
                                  ),
                                ),
                                filled: true,
                                hintStyle: new TextStyle(color: Colors.grey[600]),
                                hintText: "12345..",
                                fillColor: Color(0xfff6f8f8)),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Pickup Date",

                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                width:MediaQuery.of(context).size.width*0.77,
                                child: TextField(
                                  onChanged: (v) {
                                    date= v;
                                  },
                                  maxLines: null,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(5.0),
                                        ),
                                      ),
                                      filled: true,
                                      hintStyle: new TextStyle(color: Colors.grey[600]),
                                      hintText: date==""?"MM/DD/YYYY":date,
                                      fillColor: Color(0xfff6f8f8)),
                                ),
                              ),
                              IconButton(onPressed:()=>_selectDate(context), icon:Icon(Icons.calendar_today_outlined))

                            ],
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: imageaddbox,
                      child: Container(
                        margin: EdgeInsets.only(top: 25,),
                        height: MediaQuery.of(context).size.height * 0.17,
                        width: MediaQuery.of(context).size.width,
                        child: Stack(
                          children: [
                            Container(
                                height: MediaQuery.of(context).size.height * 0.17,
                                width: MediaQuery.of(context).size.width,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(
                                      "image/addi.jpeg",
                                      fit: BoxFit.cover,
                                    ))),
                            GestureDetector(
                              onTap: () {
                                optionaldialog(context);
                              },
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.black54,
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        child: Icon(
                                          Icons.add,
                                          size: 30,
                                          color: Colors.black54,
                                        )),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Add Images",
                                      style: TextStyle(
                                          color: Colors.black54, fontSize: 24),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                        visible: imagelistbox,
                        child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color:Colors.black),
                                color: Color(0xfff6f8f8),
                                borderRadius: BorderRadius.circular(5)),
                            margin: EdgeInsets.only(top:25),
                            height: 150,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    optionaldialog(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.black54,
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                            child: Icon(
                                              Icons.add,
                                              size: 20,
                                              color: Colors.black54,
                                            )),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Add Images",
                                          style: TextStyle(
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 100,
                                  child: ListView.builder(
                                      itemCount: imageslist.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return Stack(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Container(
                                                height: 80,
                                                width: 80,
                                                color: Colors.white,
                                                child: Image.file(
                                                  imageslist[index],
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              right: 0,
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    imageslist.removeAt(index);
                                                  });
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      shape: BoxShape.circle),
                                                  child: Icon(
                                                    Icons.clear,
                                                    color: Colors.white,
                                                    size: 15,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        );
                                      }),
                                ),


                              ],
                            ))),
                    SizedBox(height:19,),
                    Container(
                      height:45,
                        width:MediaQuery.of(context).size.width*0.9,
                        child: ElevatedButton(onPressed: (){

                          if (category != null &&
                              number != null &&
                              description != null &&
                              phone!= null &&
                              date!=""&&
                              address != null &&
                              imageslist.length != 0) {

                            setState(() {
                              showSpinner=true;
                            });


                            DocumentReference ref2 = FirebaseFirestore.instance
                                .collection(email).doc();
                            var body2 =
                            {"items": number,
                            "email":email,
                            "description": description,
                            "address":address,
                            "phone":phone,
                            "charity":category,
                            "date":date,
                              "status":"Pending"
                           };
                            ref2.set(body2);

                            DocumentReference ref = FirebaseFirestore.instance
                                .collection(charityemail.toString())
                                .doc();
                             var body = {
                              "items": number,
                              "name":email,
                               "id":ref2.id,
                              "description": description,
                              "address":address,
                              "phone":phone,
                              "charity":category,
                              "date":date, "status":"Pending"
                            };
                            ref.set(body);
                            saveImages(imageslist, ref,context);
                          } else {
                            Fluttertoast.showToast(
                                msg: "Fill Credentials ",  // message
                                toastLength: Toast.LENGTH_SHORT,
                                backgroundColor:Colors.white,
                                textColor:Colors.black54,// length
                                gravity: ToastGravity.SNACKBAR,    // location
                                timeInSecForIosWeb: 1               // duration
                            );
                          }


                        }, child:Text("Submit"))),
                    SizedBox(height:19,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

