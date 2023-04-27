import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:policyalliance/main.dart';

class register extends StatefulWidget {
  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  bool isMobileNumberValid = false;
  TextEditingController RegController = TextEditingController();
  TextEditingController RegController1 = TextEditingController();
  TextEditingController RegController2 = TextEditingController();
  TextEditingController RegController3 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(83.0),
        child: AppBar(
          leading: Container(
            child: Container(
              child: Image.asset('assets/images/Group 18.jpg'),
              height: 150.0,
              width: 500.0,
              margin: EdgeInsets.only(left: 20.0, top: 8.0),
            ),
          ),
          leadingWidth: 300.0,
          toolbarHeight: 100,
          backgroundColor: Colors.white,
          actions: <Widget>[
            ButtonBar(
              children: [
                Container(
                  height: 35,
                  width: 100,
                  margin: EdgeInsets.only(right: 100, top: 10),
                  child: ElevatedButton(
                    child: Text(
                      'Register',
                      style: TextStyle(
                          color: Color(0xFFFED662),
                          fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF07539D),
                    ),
                    onPressed: () {},
                  ),
                )
              ],
            )
          ],
        ),
      ),
      body: Container(
        height: 600,
        width: 750,
        margin: EdgeInsets.only(top: 50, left: 300, bottom: 50),
        alignment: Alignment.center,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                  height: 480.0,
                  child: Image.asset('assets/images/register.jpg',
                      fit: BoxFit.fill)),
            ),
            Expanded(
              flex: 1,
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 60),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 6.0,
                        spreadRadius: 2.0,
                        offset: Offset(0.0, 0.0),
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          margin: EdgeInsets.only(top: 30),
                          child: Text(
                            'Register',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF07539D)),
                          )),
                      Container(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            Text('Name'),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              height: 40,
                              child: TextField(
                                controller: RegController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.black,
                                          style: BorderStyle.solid)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: Colors.grey,
                                      ),
                                      borderRadius: BorderRadius.zero),
                                ),
                              ),
                            ),
                          ])),
                      Container(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            Text('Mobile Number'),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              height: 40,
                              child: TextField(
                                controller: RegController1,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(10)],
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  // Check if the mobile number has exactly 10 digits
                                  if (value.length == 10) {
                                    setState(() {
                                      isMobileNumberValid = true;
                                    });
                                  } else {
                                    setState(() {
                                      isMobileNumberValid = false;
                                    });
                                  }
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.black,
                                          style: BorderStyle.solid)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: Colors.grey,
                                      ),
                                      borderRadius: BorderRadius.zero),
                                ),
                              ),
                            ),
                          ])),
                      Container(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            Text('Create Password'),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              height: 40,
                              child: TextField(
                                controller: RegController2,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.black,
                                          style: BorderStyle.solid)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: Colors.grey,
                                      ),
                                      borderRadius: BorderRadius.zero),
                                ),
                                keyboardType: TextInputType.visiblePassword,
                              ),
                            ),
                          ])),
                      Container(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            Text('Age'),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              height: 40,
                              child: TextField(
                                controller: RegController3,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.black,
                                          style: BorderStyle.solid)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: Colors.grey,
                                      ),
                                      borderRadius: BorderRadius.zero),
                                ),
                              ),
                            ),
                          ])),
                      Container(
                        width: 252,
                        height: 35,
                        child: ElevatedButton(
                          child: Text('Register'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF07539D),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                          onPressed: () async {
                            String name = RegController.text;
                            String mobileNumber = RegController1.text;
                            String password = RegController2.text;
                            String age = RegController3.text;
                            Map<String, dynamic> requestBody = {
                              'Name': name,
                              'MobileNumber': mobileNumber,
                              'Age': age,
                              'Password': password,
                            };

                            String requestBodyJson = json.encode(requestBody);
                            print(requestBodyJson);

                            final response = await http.post(
                              Uri.parse('http://localhost:8080/home/register'),
                              headers: {
                                'Content-Type': 'application/json',
                              },
                              body: requestBodyJson,
                            );
                            Map<String, dynamic> responseBody =
                                json.decode(response.body);
                            var status = responseBody['status'];
                            print('Status: $status');

                            if (status == '201') {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  content: Text(
                                    'Your Already Register Please Login',
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PolicyAlliance()),
                                        );
                                      },
                                      child: Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  content: Text(
                                    'Your Register Successfully Please Login',
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PolicyAlliance()),
                                        );
                                      },
                                      child: Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                        ),
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
