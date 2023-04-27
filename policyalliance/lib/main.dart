import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:policyalliance/Company.dart';
import 'package:policyalliance/Customers.dart';
import 'package:policyalliance/Registration.dart';

import 'api/company-api.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: PolicyAlliance(),
  ));
}


class PolicyAlliance extends StatefulWidget {
  @override
  State<PolicyAlliance> createState() => _PolicyAllianceState();
}

class _PolicyAllianceState extends State<PolicyAlliance> {
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  num get StarIcons => 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:PreferredSize(
        preferredSize: Size.fromHeight(83.0),
        child: AppBar(
           leading: Container(
              child: Container(child: Image.asset('assets/images/Group 18.jpg'),
              height: 150.0,
              width: 500.0,
              margin: EdgeInsets.only(left: 20.0,top: 8.0),
              ),
            ),
          leadingWidth: 300.0,
          toolbarHeight: 100,
          backgroundColor: Colors.white,
          actions: <Widget>[
            ButtonBar(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 50.0, top: 10.0),
                  child: OutlinedButton(
                    child: Text(
                      'Buy Now',
                      style: TextStyle(
                        color: Color(0xFF07539D),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          // Create mobile number and password text controllers
                          TextEditingController mobileNumberController = TextEditingController();
                          TextEditingController passwordController = TextEditingController();

                          return Container(
                            child: AlertDialog(
                              content: Container(
                                width: 410,
                                height:310,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(0.0)
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(top:5,left: 30),
                                        child: Text('Enter Your Mobile Number')),
                                    Container(
                                      margin: EdgeInsets.only(top: 10,left: 30),
                                      width: 350,
                                      height: 50,
                                      child: TextField(
                                        controller: mobileNumberController,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1,color: Colors.black,style: BorderStyle.solid)),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                width: 1,
                                                color: Colors.grey,
                                              ),
                                              borderRadius: BorderRadius.zero
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top:20,left: 30),
                                      child: Text('Password'),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top:10,left: 30),
                                      width:350,
                                      height: 50,
                                      child:
                                      TextField(
                                        controller: passwordController,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1,color: Colors.black,style: BorderStyle.solid)),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                width: 1,
                                                color: Colors.grey,
                                              ),
                                              borderRadius: BorderRadius.zero
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 350,
                                      height: 50,
                                      margin:EdgeInsets.only(top:23,left: 30),
                                      child: ElevatedButton(
                                        child: Text('Submit'),
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(0xFF07539D),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.zero,
                                            )
                                        ),
                                        onPressed: () async {
                                          String mobileNumber = mobileNumberController.text;
                                          String password = passwordController.text;
                                          Map<String, dynamic> requestBody = {
                                            'MobileNumber': mobileNumber,
                                            'Password': password,
                                          };
                                          String requestBodyJson = json.encode(requestBody);
                                          print(requestBodyJson);

                                          final response = await http.post(
                                            Uri.parse('http://localhost:8080/home/users'),
                                            headers: {
                                              'Content-Type': 'application/json',
                                            },

                                            body: requestBodyJson,

                                          );
                                          Map<String, dynamic> responseBody =
                                          json.decode(response.body);
                                          print(response.body);
                                          var name = responseBody['name'];
                                          var mobilenumber=responseBody['mobileNumber'];
                                          var status = responseBody['status'];
                                          print('Name: $name');
                                          print('MobileNumber: $mobilenumber');
                                          print('Status: $status');

                                          if (status == '200') {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => companies(username:name,mobileNumber: mobilenumber,)),
                                            );
                                          }
                                          else {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) => AlertDialog(
                                                content:
                                                Text('Failed to login. Please try again.'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => PolicyAlliance()),
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
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          margin:EdgeInsets.only(top:15,left: 60),
                                          child: Text("If you don't have an account?"),
                                        ),
                                        Container(
                                          margin:EdgeInsets.only(top:15),
                                          child: TextButton(
                                            child: Text('Register',style: TextStyle(fontWeight: FontWeight.normal,decoration: TextDecoration.underline),),
                                            onPressed: (){
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context)=>  register())
                                              );
                                            },
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),

                              actions: [

                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 50.0,top: 10.0),
                  child: OutlinedButton(
                    child: Text('Customers',style: TextStyle(color: Color(0xFF07539D),fontWeight: FontWeight.bold)),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          // Create mobile number and password text controllers
                          TextEditingController mobileNumberController = TextEditingController();
                          TextEditingController passwordController = TextEditingController();

                          return Container(
                            child: AlertDialog(
                              content: Container(
                                width: 410,
                                height:170,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(0.0)
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(top:5,left: 30),
                                        child: Text('Enter Your Mobile Number')),
                                    Container(
                                      margin: EdgeInsets.only(top: 10,left: 30),
                                      width: 350,
                                      height: 50,
                                      child: TextField(
                                        controller: mobileNumberController,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1,color: Colors.black,style: BorderStyle.solid)),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                width: 1,
                                                color: Colors.grey,
                                              ),
                                              borderRadius: BorderRadius.zero
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 350,
                                      height: 50,
                                      margin:EdgeInsets.only(top:23,left: 30),
                                      child: ElevatedButton(
                                        child: Text('Submit'),
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(0xFF07539D),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.zero,
                                            )
                                        ),
                                        onPressed: () async {
                                          String mobileNumber = mobileNumberController.text;
                                          Map<String, dynamic> requestBody = {
                                            'MobileNumber': mobileNumber,

                                          };
                                          String requestBodyJson = json.encode(requestBody);
                                          print(requestBodyJson);

                                          final response = await http.post(
                                            Uri.parse('http://localhost:8080/home/users2'),
                                            headers: {
                                              'Content-Type': 'application/json',
                                            },

                                            body: requestBodyJson,

                                          );
                                          Map<String, dynamic> responseBody =
                                          json.decode(response.body);
                                          print(response.body);
                                          var status = responseBody['status'];
                                          print('Status: $status');

                                          if (status == '200') {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) => AlertDialog(
                                                content:
                                                Text("You don't have any policy please buy first"),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => PolicyAlliance()),
                                                      );
                                                    },
                                                    child: Text('OK'),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }
                                          else {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => customers()),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              actions: [

                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                Container(
                  height: 35,
                  width: 100,
                  margin: EdgeInsets.only(right: 100,top: 10),
                  child: ElevatedButton(
                    child: Text('Register',style: TextStyle(color: Color(0xFFFED662),fontWeight: FontWeight.bold),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF07539D),
                    ),
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context)=>  register())
                      );
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        child: Stack(
                          children: [
                            Container(
                              height: 550,
                              width: double.infinity,
                              color: Color(0xFFfed662),
                            ),
                            Container(
                              height: 300,
                              width: 300,
                              margin: EdgeInsets.only(left: 50,top: 70),
                              child: Image.asset('assets/images/doctor.jpg'),
                            ),
                            Container(
                              child: Text('Term Insurance and Investment Plans',style: TextStyle(fontSize: 33,fontWeight: FontWeight.bold,color: Color(0xFF07539D)),),
                              height: 300,
                              margin: EdgeInsets.only(left: 405,top: 110),
                            ),
                            Row(
                              children: [

                                Container(
                                  child:CircleAvatar(
                                      backgroundImage:AssetImage('assets/images/Save-Tax.jpg')
                                  ),
                                  height: 50,
                                  width: 50,

                                  decoration: BoxDecoration(
                                    border: Border.all(width: 1, color: Colors.black),
                                    borderRadius: BorderRadius.circular(100), //<-- SEE HERE
                                  ),
                                  margin: EdgeInsets.only(top: 170,left: 400),
                                ),
                                Container(
                                  child:Text('Tax saving upto Rs.46,800',style: TextStyle(color: Color(0xFF1278DB)),),
                                  margin: EdgeInsets.only(top: 170,left: 20),
                                ),
                                Container(
                                  child:CircleAvatar(
                                      backgroundImage:AssetImage('assets/images/Save-Tax.jpg')
                                  ),

                                  height: 50,
                                  width: 50,

                                  decoration: BoxDecoration(
                                    border: Border.all(width: 1, color: Colors.black),
                                    borderRadius: BorderRadius.circular(100), //<-- SEE HERE
                                  ),
                                  margin: EdgeInsets.only(top: 170,left: 200),
                                ),
                                Container(
                                  child:Text('5% Discount',style: TextStyle(color: Color(0xFF1278DB)),),
                                  margin: EdgeInsets.only(top: 170,left: 20),
                                ),
                              ],

                            ),
                            Container(
                              child:CircleAvatar(
                                  backgroundImage:AssetImage('assets/images/Save-Tax.jpg')
                              ),
                              height: 50,
                              width: 50,

                              decoration: BoxDecoration(
                                border: Border.all(width: 1, color: Colors.black),
                                borderRadius: BorderRadius.circular(100), //<-- SEE HERE
                              ),
                              margin: EdgeInsets.only(top: 270,left: 400),
                            ),
                            Container(
                              child:Text('99.34% Claims Paid Ratio',style: TextStyle(color: Color(0xFF1278DB)),),
                              margin: EdgeInsets.only(top: 285,left: 473),
                            ),
                            Container(
                              child:CircleAvatar(
                                  backgroundImage:AssetImage('assets/images/Save-Tax.jpg')
                              ),
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                border: Border.all(width: 1, color: Colors.black),
                                borderRadius: BorderRadius.circular(100), //<-- SEE HERE
                              ),
                              margin: EdgeInsets.only(top: 270,left: 838),
                            ),
                            Container(
                              child:Text('Zero Commission',style: TextStyle(color: Color(0xFF1278DB)),),
                              margin: EdgeInsets.only(top: 285,left: 910),
                            ),
                            Container(
                              width: 120,
                              margin: EdgeInsets.only(top: 370,left: 400),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF07539D),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                  )
                                ),

                                child: Text('Get Start',style: TextStyle(fontSize: 10),),
                                onPressed: (){},
                              ),
                            ),

                            Container(
                              height: 50,
                              width: 130,
                              margin: EdgeInsets.only(left: 1070,top:30),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFFFFFAED),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero,

                                    )
                                ),
                                child:Text('Search',style: TextStyle(color:Color(0xFF07539D),fontSize: 20),),
                                onPressed: (){},
                              ),
                            ),
                            Container(
                              width: 800,
                              margin: EdgeInsets.only(left: 250,top: 30),
                              child: const TextField(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xFFFFFAED),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                keyboardType: TextInputType.name,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 260,top: 43),
                              child: Icon(Icons.search),
                            ),
                            Container(
                              height: 300,
                              width: 1230,
                              margin: EdgeInsets.only(top: 470,left: 80),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(0),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color:Colors.grey,
                                    blurRadius: 6.0,
                                    spreadRadius: 2.0,
                                    offset: Offset(0.0, 0.0),
                                  )
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 200,
                                  width: 250,
                                  margin: EdgeInsets.only(left: 120,top: 520),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(0),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color:Colors.grey,
                                        blurRadius: 6.0,
                                        spreadRadius: 2.0,
                                        offset: Offset(0.0, 0.0),
                                      )
                                    ],
                                  ),
                                  child:Column(
                                    children: [
                                      Container(
                                        margin:EdgeInsets.only(top:40),
                                        child:CircleAvatar(
                                          backgroundImage:AssetImage('assets/images/Save-Tax.jpg'),
                                        ),
                                        height: 70,
                                        width: 70,

                                        decoration: BoxDecoration(
                                          border: Border.all(width: 1, color: Colors.black),
                                          borderRadius: BorderRadius.circular(100), //<-- SEE HERE
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top:25),
                                        child: Text('Business Companies',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Color(0xFF07539D)),),
                                      ),

                                    ],
                                  ),
                                ),

                                Container(
                                  height: 200,
                                  width: 250,
                                  margin: EdgeInsets.only(left: 50,top: 518),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(0),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color:Colors.grey,
                                        blurRadius: 6.0,
                                        spreadRadius: 2.0,
                                        offset: Offset(0.0, 0.0),
                                      )
                                    ],
                                  ),
                                  child:Column(
                                    children: [
                                      Container(
                                        margin:EdgeInsets.only(top:40),
                                        child:CircleAvatar(
                                          backgroundImage:AssetImage('assets/images/Save-Tax.jpg'),
                                        ),
                                        height: 70,
                                        width: 70,

                                        decoration: BoxDecoration(
                                          border: Border.all(width: 1, color: Colors.black),
                                          borderRadius: BorderRadius.circular(100), //<-- SEE HERE
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top:25),
                                        child: Text('Personal Healthy',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Color(0xFF07539D)),),
                                      ),

                                    ],
                                  ),
                                ),
                                Container(
                                  height: 200,
                                  width: 250,
                                  margin: EdgeInsets.only(left: 50,top: 518),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(0),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color:Colors.grey,
                                        blurRadius: 6.0,
                                        spreadRadius: 2.0,
                                        offset: Offset(0.0, 0.0),
                                      )
                                    ],
                                  ),
                                  child:Column(
                                    children: [
                                      Container(
                                        margin:EdgeInsets.only(top:40),
                                        child:CircleAvatar(
                                          backgroundImage:AssetImage('assets/images/Save-Tax.jpg'),
                                        ),
                                        height: 70,
                                        width: 70,

                                        decoration: BoxDecoration(
                                          border: Border.all(width: 1, color: Colors.black),
                                          borderRadius: BorderRadius.circular(100), //<-- SEE HERE
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top:25),
                                        child: Text('Life Insurance',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Color(0xFF07539D)),),
                                      ),

                                    ],
                                  ),
                                ),
                                Container(
                                  height: 200,
                                  width: 250,
                                  margin: EdgeInsets.only(left: 50,top: 518),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(0),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color:Colors.grey,
                                        blurRadius: 6.0,
                                        spreadRadius: 2.0,
                                        offset: Offset(0.0, 0.0),
                                      )
                                    ],
                                  ),
                                  child:Column(
                                    children: [
                                      Container(
                                        margin:EdgeInsets.only(top:40),
                                        child:CircleAvatar(
                                          backgroundImage:AssetImage('assets/images/Save-Tax.jpg'),
                                        ),
                                        height: 70,
                                        width: 70,

                                        decoration: BoxDecoration(
                                          border: Border.all(width: 1, color: Colors.black),
                                          borderRadius: BorderRadius.circular(100), //<-- SEE HERE
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top:25),
                                        child: Text('Educational Fund',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Color(0xFF07539D)),),
                                      ),

                                    ],
                                  ),
                                ),

                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  child: Text('Some reasons why\nwe are better than others',
                                    style: TextStyle(fontSize: 40,color: Color(0xFF07539D)),
                                  ),
                                  margin: EdgeInsets.only(left:80,top: 830),
                                ),
                                Container(
                                  child: Text('We provide the most comprehensive protection to you and your\nfamily in times of need. It provides financial protection\nin case an eventuality strikes. However, to be fully utilized the\nbest star health insurance policies, it is vital to make an informed decision while buying a plan.'),
                                  margin: EdgeInsets.only(top: 830,left: 100),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  child: Text('Our Plan For Your Strategies',style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: Color(0xFF07539D)),),
                                  margin: EdgeInsets.only(top: 1000,left: 450),

                                )
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  child: Text('Discover Health Insurance With Opd At Shopwebly! - Easily Found! Easy Access. Quick Results.\nMany Products. Search and Discover. Compare Products. Find Easily. Types: News, Video, Images, Web, Wiki.'),
                                  margin: EdgeInsets.only(top: 1080,left: 350),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                   height: 40,
                                   width: 240,
                                   color: Color(0xFF07539D),
                                     margin: EdgeInsets.only(top: 1150,left: 550),
                                    child:Row(
                                      children: [
                                        Container(
                                          height: 30,
                                          width:110,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.zero,
                                              ),
                                            ),
                                            child:Text('Annually Plan',style: TextStyle(color: Color(0xFF07539D),fontSize: 10),),
                                            onPressed: (){},
                                          ),
                                          margin: EdgeInsets.only(top: 0,left: 10),
                                        ),
                                        Container(
                                          height: 30,
                                          width:110,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Color(0xFF07539D),
                                              shadowColor: Color(0),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.zero,
                                              ),
                                            ),
                                            child:Text('Monthly Plan',style: TextStyle(fontSize: 10),),
                                            onPressed: (){},
                                          ),
                                          margin: EdgeInsets.only(top: 0,),
                                        )
                                      ],
                                    )
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                    margin: EdgeInsets.only(top: 1230,left: 90),
                                    color: Color(0xFFD3E9FF),
                                    width: 320,
                                    height:400,
                                  child:Column(
                                     children:[
                                       Container(

                                       child: Text('Lite Plan',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Color(0xFF014A71)),),
                                       padding:EdgeInsets.only(top: 40),
                                       alignment: Alignment.topCenter,
                                     ),
                                       Container(
                                         margin: EdgeInsets.only(top: 30),
                                         child: Text('Lite Plan allows you and your family\nto purchase affordable short-term medical\ncoverage for physician services,\nsurgery, outpatient and inpatient care.',style: TextStyle(fontSize:10,fontWeight: FontWeight.bold),),
                                         alignment: Alignment.topCenter,
                                       ),
                                       Container(
                                         margin:EdgeInsets.only(top: 30),
                                         child: Text(r"$150/month",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Color(0xFF014A71)),),
                                       ),
                                       Container(
                                         margin: EdgeInsets.only(top: 35),
                                         child: Text('•  3 Months of care',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                                         alignment: Alignment.topCenter,
                                       ),
                                       Container(
                                           margin: EdgeInsets.only(top: 10),
                                           child: Text('•  4 Part health plan',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold)),
                                           alignment: Alignment.topCenter,
                                       ),
                                       Container(
                                           margin: EdgeInsets.only(top: 10),
                                           child: Text('•  Health plan update',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold)),
                                           alignment: Alignment.topCenter,
                                       ),
                                       Container(
                                         margin: EdgeInsets.only(top: 35),
                                         width: 200,
                                         child: ElevatedButton(
                                           style: ElevatedButton.styleFrom(
                                               backgroundColor: Color(0xFF98D6F7),
                                               shape: RoundedRectangleBorder(
                                                 borderRadius: BorderRadius.zero,
                                               ),
                                           ),
                                           child: Text('Select Plan',style: TextStyle(fontSize: 12,color: Color(0xFF014A71)),),
                                           onPressed: (){},
                                         ),
                                       )
                                     ] ,
                                  )


                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 1230,left: 90),
                                    color: Color(0xFFFED662),
                                    width: 320,
                                    height:400,
                                    child:Column(
                                      children:[
                                        Container(

                                          child: Text('Basic Plan',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Color(0xFF014A71)),),
                                          padding:EdgeInsets.only(top: 40),
                                          alignment: Alignment.topCenter,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 30),
                                          child: Text('One can add value to the Base\n Health Insurance Plan by complementing them\nwith additional benefits such as Personal Accident (PA)\nCover, Critical Illness (CI) Cover, etc.',style: TextStyle(fontSize:10,fontWeight: FontWeight.bold),),
                                          alignment: Alignment.topCenter,
                                        ),
                                        Container(
                                          margin:EdgeInsets.only(top: 30),
                                          child: Text(r"$250/month",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Color(0xFF014A71)),),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 35),
                                          child: Text('•  12 Months of care',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                                          alignment: Alignment.topCenter,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 10),
                                          child: Text('•  12 Part health plan',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold)),
                                          alignment: Alignment.topCenter,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 10),
                                          child: Text('•  Health plan update',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold)),
                                          alignment: Alignment.topCenter,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 35),
                                          width: 200,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Color(0xFF07539D),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.zero,
                                              ),
                                            ),
                                            child: Text('Select Plan',style: TextStyle(fontSize: 12,color: Colors.white),),
                                            onPressed: (){},
                                          ),
                                        )
                                      ] ,
                                    )


                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 1230,left: 90),
                                    color: Color(0xFFD3E9FF),
                                    width: 320,
                                    height:400,
                                    child:Column(
                                      children:[
                                        Container(

                                          child: Text('Premium Plan',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Color(0xFF014A71)),),
                                          padding:EdgeInsets.only(top: 40),
                                          alignment: Alignment.topCenter,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 30),
                                          child: Text('Premium plans offer coverage\nagainst several types of ailments and surgeries,\nalong with other aspects of medical treatment',style: TextStyle(fontSize:10,fontWeight: FontWeight.bold),),
                                          alignment: Alignment.topCenter,
                                        ),
                                        Container(
                                          margin:EdgeInsets.only(top: 30),
                                          child: Text(r"$500/month",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Color(0xFF014A71)),),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 35),
                                          child: Text('•  Unlimited of Care',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                                          alignment: Alignment.topCenter,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 10),
                                          child: Text('•  50 Part health plan',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold)),
                                          alignment: Alignment.topCenter,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 10),
                                          child: Text('•  Health plan update',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold)),
                                          alignment: Alignment.topCenter,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 50),
                                          width: 200,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Color(0xFF98D6F7),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.zero,
                                              ),
                                            ),
                                            child: Text('Select Plan',style: TextStyle(fontSize: 12,color: Color(0xFF014A71)),),
                                            onPressed: (){},
                                          ),
                                        )
                                      ] ,
                                    )


                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  margin:EdgeInsets.only(top:1700,left: 25),
                                  child: Text('Top Recommended Companies',style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color: Color(0xFF07539D))),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                    margin: EdgeInsets.only(top: 1780,left: 25),
                                    width: 230,
                                    height:240,
                                    child:Column(
                                      children:[
                                        Container(

                                          child: Image.asset('assets/images/StarHealth.jpg'),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 20),
                                          child: Text('Star Health Insurance',style: TextStyle(fontSize:17,fontWeight: FontWeight.bold),),
                                          alignment: Alignment.centerLeft,

                                        ),
                                        Container(
                                          margin:EdgeInsets.only(top: 10),
                                          child: Text('Base Plan'),
                                          alignment: Alignment.centerLeft,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 10.0),
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: [
                                              for (var i = 0; i < 5; i++)
                                                Icon(
                                                  i < StarIcons ? Icons.star : Icons.star_border,
                                                  color: i < StarIcons
                                                      ? Color(0xFFF26F20)
                                                      : Color(0xFFF26F20),
                                                  size: 15,
                                                ),
                                            ],
                                          ),
                                        ),

                                      ] ,
                                    )


                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 1780,left: 25),
                                    width: 230,
                                    height:240,
                                    child:Column(
                                      children:[
                                        Container(

                                          child: Image.asset('assets/images/StarHealth.jpg'),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 20),
                                          child: Text('Star Health Insurance',style: TextStyle(fontSize:17,fontWeight: FontWeight.bold),),
                                          alignment: Alignment.centerLeft,

                                        ),
                                        Container(
                                          margin:EdgeInsets.only(top: 10),
                                          child: Text('Base Plan'),
                                          alignment: Alignment.centerLeft,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 10.0),
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: [
                                              for (var i = 0; i < 5; i++)
                                                Icon(
                                                  i < StarIcons ? Icons.star : Icons.star_border,
                                                  color: i < StarIcons
                                                      ? Color(0xFFF26F20)
                                                      : Color(0xFFF26F20),
                                                  size: 15,
                                                ),
                                            ],
                                          ),
                                        ),

                                      ] ,
                                    )


                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 1780,left: 25),
                                    width: 230,
                                    height:240,
                                    child:Column(
                                      children:[
                                        Container(

                                          child: Image.asset('assets/images/StarHealth.jpg'),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 20),
                                          child: Text('Star Health Insurance',style: TextStyle(fontSize:17,fontWeight: FontWeight.bold),),
                                          alignment: Alignment.centerLeft,

                                        ),
                                        Container(
                                          margin:EdgeInsets.only(top: 10),
                                          child: Text('Base Plan'),
                                          alignment: Alignment.centerLeft,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 10.0),
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: [
                                              for (var i = 0; i < 5; i++)
                                                Icon(
                                                  i < StarIcons ? Icons.star : Icons.star_border,
                                                  color: i < StarIcons
                                                      ? Color(0xFFF26F20)
                                                      : Color(0xFFF26F20),
                                                  size: 15,
                                                ),
                                            ],
                                          ),
                                        ),

                                      ] ,
                                    )


                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 1780,left: 25),
                                    width: 230,
                                    height:240,
                                    child:Column(
                                      children:[
                                        Container(

                                          child: Image.asset('assets/images/StarHealth.jpg'),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 20),
                                          child: Text('Star Health Insurance',style: TextStyle(fontSize:17,fontWeight: FontWeight.bold),),
                                          alignment: Alignment.centerLeft,

                                        ),
                                        Container(
                                          margin:EdgeInsets.only(top: 10),
                                          child: Text('Base Plan'),
                                          alignment: Alignment.centerLeft,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 10.0),
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: [
                                              for (var i = 0; i < 5; i++)
                                                Icon(
                                                  i < StarIcons ? Icons.star : Icons.star_border,
                                                  color: i < StarIcons
                                                      ? Color(0xFFF26F20)
                                                      : Color(0xFFF26F20),
                                                  size: 15,
                                                ),
                                            ],
                                          ),
                                        ),

                                      ] ,
                                    )


                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 1780,left: 25),
                                    width: 230,
                                    height:240,
                                    child:Column(
                                      children:[
                                        Container(

                                          child: Image.asset('assets/images/StarHealth.jpg'),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 20),
                                          child: Text('Star Health Insurance',style: TextStyle(fontSize:17,fontWeight: FontWeight.bold),),
                                          alignment: Alignment.centerLeft,

                                        ),
                                        Container(
                                          margin:EdgeInsets.only(top: 10),
                                          child: Text('Base Plan'),
                                          alignment: Alignment.centerLeft,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 10.0),
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: [
                                              for (var i = 0; i < 5; i++)
                                                Icon(
                                                  i < StarIcons ? Icons.star : Icons.star_border,
                                                  color: i < StarIcons
                                                      ? Color(0xFFF26F20)
                                                      : Color(0xFFF26F20),
                                                  size: 15,
                                                ),
                                            ],
                                          ),
                                        ),

                                      ] ,
                                    )


                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                    margin: EdgeInsets.only(top: 2030,left: 25),
                                    width: 230,
                                    height:240,
                                    child:Column(
                                      children:[
                                        Container(

                                          child: Image.asset('assets/images/StarHealth.jpg'),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 20),
                                          child: Text('Star Health Insurance',style: TextStyle(fontSize:17,fontWeight: FontWeight.bold),),
                                          alignment: Alignment.centerLeft,

                                        ),
                                        Container(
                                          margin:EdgeInsets.only(top: 10),
                                          child: Text('Base Plan'),
                                          alignment: Alignment.centerLeft,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 10.0),
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: [
                                              for (var i = 0; i < 5; i++)
                                                Icon(
                                                  i < StarIcons ? Icons.star : Icons.star_border,
                                                  color: i < StarIcons
                                                      ? Color(0xFFF26F20)
                                                      : Color(0xFFF26F20),
                                                  size: 15,
                                                ),
                                            ],
                                          ),
                                        ),

                                      ] ,
                                    )


                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 2030,left: 25),
                                    width: 230,
                                    height:240,
                                    child:Column(
                                      children:[
                                        Container(

                                          child: Image.asset('assets/images/StarHealth.jpg'),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 20),
                                          child: Text('Star Health Insurance',style: TextStyle(fontSize:17,fontWeight: FontWeight.bold),),
                                          alignment: Alignment.centerLeft,

                                        ),
                                        Container(
                                          margin:EdgeInsets.only(top: 10),
                                          child: Text('Base Plan'),
                                          alignment: Alignment.centerLeft,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 10.0),
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: [
                                              for (var i = 0; i < 5; i++)
                                                Icon(
                                                  i < StarIcons ? Icons.star : Icons.star_border,
                                                  color: i < StarIcons
                                                      ? Color(0xFFF26F20)
                                                      : Color(0xFFF26F20),
                                                  size: 15,
                                                ),
                                            ],
                                          ),
                                        ),

                                      ] ,
                                    )


                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 2030,left: 25),
                                    width: 230,
                                    height:240,
                                    child:Column(
                                      children:[
                                        Container(

                                          child: Image.asset('assets/images/StarHealth.jpg'),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 20),
                                          child: Text('Star Health Insurance',style: TextStyle(fontSize:17,fontWeight: FontWeight.bold),),
                                          alignment: Alignment.centerLeft,

                                        ),
                                        Container(
                                          margin:EdgeInsets.only(top: 10),
                                          child: Text('Base Plan'),
                                          alignment: Alignment.centerLeft,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 10.0),
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: [
                                              for (var i = 0; i < 5; i++)
                                                Icon(
                                                  i < StarIcons ? Icons.star : Icons.star_border,
                                                  color: i < StarIcons
                                                      ? Color(0xFFF26F20)
                                                      : Color(0xFFF26F20),
                                                  size: 15,
                                                ),
                                            ],
                                          ),
                                        ),

                                      ] ,
                                    )


                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 2030,left: 25),
                                    width: 230,
                                    height:240,
                                    child:Column(
                                      children:[
                                        Container(

                                          child: Image.asset('assets/images/StarHealth.jpg'),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 20),
                                          child: Text('Star Health Insurance',style: TextStyle(fontSize:17,fontWeight: FontWeight.bold),),
                                          alignment: Alignment.centerLeft,

                                        ),
                                        Container(
                                          margin:EdgeInsets.only(top: 10),
                                          child: Text('Base Plan'),
                                          alignment: Alignment.centerLeft,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 10.0),
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: [
                                              for (var i = 0; i < 5; i++)
                                                Icon(
                                                  i < StarIcons ? Icons.star : Icons.star_border,
                                                  color: i < StarIcons
                                                      ? Color(0xFFF26F20)
                                                      : Color(0xFFF26F20),
                                                  size: 15,
                                                ),
                                            ],
                                          ),
                                        ),

                                      ] ,
                                    )


                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 2030,left: 25),
                                    width: 230,
                                    height:240,
                                    child:Column(
                                      children:[
                                        Container(

                                          child: Image.asset('assets/images/StarHealth.jpg'),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 20),
                                          child: Text('Star Health Insurance',style: TextStyle(fontSize:17,fontWeight: FontWeight.bold),),
                                          alignment: Alignment.centerLeft,

                                        ),
                                        Container(
                                          margin:EdgeInsets.only(top: 10),
                                          child: Text('Base Plan'),
                                          alignment: Alignment.centerLeft,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 10.0),
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: [
                                              for (var i = 0; i < 5; i++)
                                                Icon(
                                                  i < StarIcons ? Icons.star : Icons.star_border,
                                                  color: i < StarIcons
                                                      ? Color(0xFFF26F20)
                                                      : Color(0xFFF26F20),
                                                  size: 15,
                                                ),
                                            ],
                                          ),
                                        ),

                                      ] ,
                                    )


                                ),
                              ],
                            )

                          ],
                        ),
                    ),
                  ],
                ),
              ),
          ),
        ],
      ),
    );
  }
}
