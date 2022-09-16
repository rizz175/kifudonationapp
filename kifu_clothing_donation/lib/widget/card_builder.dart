// // ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/model/user_model.dart';
// import 'package:flutter_application_1/widget/button_widget.dart';
// import 'package:flutter_application_1/widget/header_builder.dart';

// import 'image_builder.dart';

// // UserModel loggedInUser = UserModel();
// // get(path) async {
// //   await FirebaseFirestore.instance
// //       .collection("users")
// //       .doc("1")
// //       .collection("Charity")
// //       .doc(path)
// //       .get()
// //       .then((value) {
// //     loggedInUser = UserModel.fromMap(value.data());
// //   });
// // }

// Card buildImageInteractionCard(String field, String name) {
//   // loggedInUser = get(st);
//   // if (str == "Donors") {
//   return Card(
//     clipBehavior: Clip.antiAlias,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(24),
//     ),
//     child: Column(
//       children: [
//         headerP(name),
//         Stack(
//           children: [
//             //   loggedInUser.imageFile != null
//             //       ? buildImageFile(loggedInUser.imageFile, 200, 200)
//             // : const
//             Icon(
//               Icons.person,
//               size: 25.0,
//               color: Colors.black,
//             ),
//           ],
//         ),
//         Padding(
//           padding: EdgeInsets.all(16).copyWith(bottom: 0),
//           child: Text(
//             '$field',
//             style: TextStyle(fontSize: 16),
//           ),
//         ),
//         ButtonBar(
//           alignment: MainAxisAlignment.start,
//           children: [
//             FlatButton(
//               // color: Color(0xff514644),
//               child: Text('Donate'),
//               onPressed: () {},
//             ),
//           ],
//         )
//       ],
//     ),
//   );
//   // }
//   // else {
//   //   return Card(
//   //     clipBehavior: Clip.antiAlias,
//   //     shape: RoundedRectangleBorder(
//   //       borderRadius: BorderRadius.circular(24),
//   //     ),
//   //     child: Column(
//   //       // key: k = UniqueKey(),
//   //       children: [
//   //         headerP1(name, loggedInUser),
//   //         Stack(
//   //           children: [
//   //             loggedInUser.imageFile != null
//   //                 ? buildImageFile(loggedInUser.imageFile, 200, 200)
//   //                 : const Icon(
//   //                     Icons.person,
//   //                     size: 25.0,
//   //                     color: Colors.black,
//   //                   ),
//   //           ],
//   //         ),
//   //         Padding(
//   //           padding: EdgeInsets.all(16).copyWith(bottom: 0),
//   //           child: Text(
//   //             '$field',
//   //             style: TextStyle(fontSize: 16),
//   //           ),
//   //         ),
//   //         ButtonBar(
//   //           alignment: MainAxisAlignment.start,
//   //           children: [
//   //             FlatButton(
//   //               // color: Color(0xff514644),
//   //               child: Text('Donate'),
//   //               onPressed: () {},
//   //             ),
//   //           ],
//   //         )
//   //       ],
//   //     ),
//   //   );
//   // }
// }

// @override
// Widget build(BuildContext context) {
//   // TODO: implement build
//   throw UnimplementedError();
// }
