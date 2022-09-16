import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CharityModel {

  String? uid='';
  String? email='';
  String? about='';
  String? fullName='';
  String? phone='';
  String? password='';
  String? imageFile='';
  String? recived="0";
  String? target="0";
  // String? imageField;
  String? charityType='';
  String? cityname='';


  CharityModel({
      this.uid,
      this.email,
      this.about,
      this.fullName,
      this.phone,
      this.password,
      this.imageFile,
      this.recived,
      this.target,
      this.charityType,
      this.cityname}); // receiving data from server
  factory CharityModel.fromMap(map) {
    return CharityModel(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      fullName: map['fullName']  ?? "23232" ,
      phone: map['phone'] ?? '',
      password: map['password'] ?? '',
      about: map['about'] ?? '',
      imageFile: map['imageFile'] ?? '',
      charityType: map['charityType'] ?? '',
      cityname: map['cityname'] ?? '',

      target: map['target'] ?? '',
      recived: map['recieved'] ?? '',
    );
  }
  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'fullName': fullName,
      'phone': phone,
      'password': password,
      'cityname': cityname,
      'about': about,
      'imageFile': imageFile,'recieved':recived,'target':target,

      "charityType": charityType,
    };
  }
}
