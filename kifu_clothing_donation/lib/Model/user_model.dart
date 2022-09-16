import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserModel {
  List<UserModel> users = [];
  String? uid;
  String? email;
  String? about;
  String? firstName;
  String? secondName;
  String? password;
  String? field;
  String? imageFile;
  // String? imageField;
  String? charityType;
  UserModel(
      {this.uid,
      this.email,
      this.firstName,
      this.secondName,
      this.password,
      this.field,
      this.charityType,this.about,
      this.imageFile});



  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      firstName: map['firstName']==null ? "23232" :map['firstName'],
      secondName: map['secondName'] ?? '',
      password: map['password'] ?? '',
      about: map['about'] ?? '',
      imageFile: map['imageFile'] ?? '',
      charityType: map['charityType'] ?? '',
      field: map['field'] ?? '',
    );
  }
  Future<List<UserModel>> getUsersList() async {
    String dataURL =
        "https://project-graduation-56682-default-rtdb.firebaseio.com/";
    List<UserModel> usersList = [];
    var url = Uri.parse("$dataURL/field");
    var response = await http.get(url);
    print("status code : ${response.statusCode}");

    print("status code : ${usersList.length}");
    var body = json.decode(response.body);

    for (var i = 0; i < body.length; i++) {
      usersList.add(UserModel.fromMap(body[i]));
    }
    return usersList;
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
      'password': password,
      'field': field,
      'about': about,
      'imageFile': imageFile,
      // 'imageField': imageField,
      "charityType": charityType,
    };
  }

  Map<String, dynamic> toMapPic() {
    return {
      'imageFile': imageFile,
    };
  }

  Map<String, dynamic> toMapPost() {
    return {
      'CharityName': firstName,
      'CharityID': uid,
      'field': field,
      // 'field': field,
      // 'imageField': imageField
    };
  }
}
