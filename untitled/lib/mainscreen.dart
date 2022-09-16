import 'dart:developer';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SessionScreen extends StatefulWidget {
  const SessionScreen({Key? key}) : super(key: key);

  @override
  _SessionScreenState createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  void convertTodate(String inputdata) {
    List<String> monthlist = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    String fulldate = inputdata.substring(42);
    String month = fulldate.replaceAll(RegExp('[^A-Za-z]'), '');
    String numbers = fulldate.replaceAll(RegExp('[^0-9]'), '');
    String days = numbers.substring(0, 2);
    String year = numbers.substring(2, 6);
    String monthNumber = "01";
    for (int i = 0; i < monthlist.length; i++) {
      log(i.toString());
      if (monthlist[i] == "Jun") {
        if (i > 8) {
          monthNumber = "${i + 1}";
        } else {
          monthNumber = "${i + 1}";
        }
      }
    }
    String formatDate = monthNumber + "/" + days + "/" + year;
    log(formatDate);
  }

  @override
  Widget build(BuildContext context) {
    var primaryColor = Color(0xff0c7b7d);

    var secondryColor = Color(0xffccfdfe);
    var wsize = MediaQuery.of(context).size.width;
    var hsize = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Color(0xffff4f6f6),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: wsize,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: primaryColor,
                                  size: 15,
                                )),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Back",
                              style: TextStyle(color: primaryColor),
                            )
                          ],
                        ),
                        Text("PHQ-9: Athletics Group",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        Text(
                          "asdsadsa",
                          style: TextStyle(color: Color(0xffff4f6f6)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: wsize,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.check_box_outlined,
                                    color: primaryColor,
                                    size: 13,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text("PHQ-9 Questionaire Results",
                                      style: TextStyle(
                                          color: primaryColor,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "09/21/2022",
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                  Text(
                                    "Date Taken",
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 10),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                              "You seem to be quite down and may have depression.A conselor may be a wise next step for professional support.",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 17)),
                        ),
                        Container(
                          width: wsize,
                          margin: EdgeInsets.only(top: 30),
                          child: Row(
                            children: [
                              Container(
                                width: wsize * 0.45,
                                decoration: BoxDecoration(
                                  border: Border(
                                      top: BorderSide(color: Colors.black12),
                                      right: BorderSide(color: Colors.black12)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        "34",
                                        style: TextStyle(
                                            color: primaryColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Score",
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 10),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: wsize * 0.45,
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(color: Colors.black12),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        "^4",
                                        style: TextStyle(
                                            color: primaryColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Change",
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 10),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                      "Trouble concentrating on things, such as reading the newspaper or watching television",
                      style: TextStyle(color: Colors.black, fontSize: 12)),
                  SizedBox(
                    height: 5,
                  ),
                  Text("Not at all",
                      style: TextStyle(fontSize: 18, color: Colors.black)),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                      "Feeling bad about yourself - or that you are a failure or have let yourself or your family down",
                      style: TextStyle(color: Colors.black, fontSize: 12)),
                  SizedBox(
                    height: 5,
                  ),
                  Text("Several Days",
                      style: TextStyle(fontSize: 18, color: Colors.black)),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Feeling down, depressed, or hopeless?",
                      style: TextStyle(color: Colors.black, fontSize: 12)),
                  Text("More than half the days",
                      style: TextStyle(fontSize: 18, color: Colors.black)),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                      "Thoughts that you would be better off dead or of hurting yourself in some way",
                      style: TextStyle(color: Colors.black, fontSize: 12)),
                  Text("Nearly every day",
                      style: TextStyle(fontSize: 18, color: Colors.black)),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Feeling tired or having little energy?",
                      style: TextStyle(color: Colors.black, fontSize: 12)),
                  Text("Some of the time",
                      style: TextStyle(fontSize: 18, color: Colors.black)),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Another question? ",
                      style: TextStyle(color: Colors.black, fontSize: 12)),
                  Text("More than half the days",
                      style: TextStyle(fontSize: 18, color: Colors.black))
                ],
              ),
            ),
          ),
        ));
  }

  @override
  void initState() {
    convertTodate(
        "default.resume_or_replay_session_fromWed, 01 Jun 2022 13:48:21");
  }
}
