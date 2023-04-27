import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:policyalliance/modal/companies-modal.dart';
import 'package:intl/intl.dart';
import 'api/company-api.dart';
import 'main.dart';




class companies extends StatefulWidget {
  final String username;
  final int mobileNumber;
  const companies({Key? key,required this.username,required this.mobileNumber}):super(key:key);
  @override
  State<companies> createState() => _companiesState(username , mobileNumber);
}

class _companiesState extends State<companies> {

  final String username;
  final int mobileNumber;
  TextEditingController passwordController = TextEditingController();

  _companiesState(this.username, this.mobileNumber);

  Future<void> ShowOrderSummary(BuildContext context, companyDetail) async {
    String? valueChoose;
    List listItem=["Gpay","phonepe","paytm"];
    String upiId ="";
    bool isDropDownEnable= false;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
      return StatefulBuilder(
          builder: (context, setState){
        return AlertDialog(
          content: Container(
            padding: EdgeInsets.symmetric(horizontal: 35),
            width: 450.0,
            height: 550.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 25.0),
                  child: Text(
                    'Order Summary',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Color(0xFF07539D),
                    ),
                  ),
                ),
                Container(
                  width: 450,
                  margin: EdgeInsets.only(top: 17.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment:MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text('Company Name',style: TextStyle(fontSize: 16),),
                          ),
                          Container(

                            child: Text(companyDetail.companyName,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment:MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Text('Plan',style: TextStyle(fontSize: 16),),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Text(companyDetail.plan,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment:MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Text('Plan Amount',style: TextStyle(fontSize: 16),),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Text(companyDetail.premiumAmount,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment:MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Text('GST',style: TextStyle(fontSize: 16),),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Text('0.00',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment:MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Text('Total Amount',style: TextStyle(fontSize: 16),),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Text(companyDetail.premiumAmount,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top:10),
                        child: Divider(
                          color: Colors.black12,
                          height: 25,
                          thickness: 2,
                          indent: 4,
                          endIndent: 4,
                        ),
                      ),
                      Container(
                        child: Text('Select Payment Method',style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Color(0xFF07539D),
                        ),),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder( //<-- SEE HERE
                                borderSide: BorderSide(color: Colors.black, width: .5),
                                borderRadius: BorderRadius.zero
                            ),
                            focusedBorder: OutlineInputBorder( //<-- SEE HERE
                                borderSide: BorderSide(color: Colors.black, width: .5),
                                borderRadius: BorderRadius.zero
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          hint: Text('UPI Apps'),
                          value: valueChoose,
                          onChanged: (newValue){
                            setState(() {
                              valueChoose= newValue.toString();
                              isDropDownEnable= true;
                            });
                          },
                          items: listItem.map((valueItem) {
                            return DropdownMenuItem(
                              value: valueItem,
                              child: Text(valueItem),
                            );
                          }).toList(),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top:10),
                        child: Text('UPI ID'),
                      ),
                      Container(
                        margin: EdgeInsets.only(top:10),
                        child: TextField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            hintText: 'Enter UPI ID',
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
                          enabled: isDropDownEnable,
                          onChanged: (value) {
                            setState(() {
                              upiId = value;
                            });
                          },
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            width: 130,
                            height: 50,
                            child: OutlinedButton(
                              child: Text('Cancel',style: TextStyle(color: Color(0xFF07539D)),),
                              onPressed: (){
                               Navigator.pop(context);
                              },
                              style: OutlinedButton.styleFrom( //<-- SEE HERE
                                  side: BorderSide(width:0.5,color: Color(0xFF07539D)),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero
                                  )
                              ),
                            ),
                          ),
                          Container(
                            width: 130,
                            height: 50,
                            margin: EdgeInsets.only(top: 20,left: 120),
                            child: ElevatedButton(
                              child: Text('Confirm'),
                              // onPressed: upiId.trim().isEmpty ? null :(){},
                              onPressed: upiId.trim().isEmpty ? null :()async {
                                DateTime now = DateTime.now();
                                String formattedDate = DateFormat('M/d/yyyy').format(now);
                                DateTime oneYearFromNow = now.add(Duration(days: 365));
                                String formattedOneYearFromNow = DateFormat('M/d/yyyy').format(oneYearFromNow);
                                Map<String, dynamic> requestBody = {
                                  'userName':username,
                                  'userMobileNumber': mobileNumber.toString(),
                                  'PaymentVia': valueChoose,
                                  'PolicyStartdate': formattedDate,
                                  'PolicyEndDate': formattedOneYearFromNow,
                                  'Amount': companyDetail.premiumAmount,
                                  'CompanyName':companyDetail.companyName,
                                  'Plan': companyDetail.plan,

                                };

                                String requestBodyJson = json.encode(requestBody);
                                print(requestBodyJson);

                                final response = await http.post(
                                  Uri.parse('http://localhost:8080/home/company2'),
                                  headers: {
                                    'Content-Type': 'application/json',
                                  },
                                  body: requestBodyJson,
                                );
                                Map<String, dynamic> responseBody =
                                json.decode(response.body);
                                var status = responseBody['status'];
                                print('Status: $status');

                                if (status == '200') {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) => SizedBox(

                                      child: AlertDialog(
                                        content: Container(
                                          width: 300.0,
                                          height: 150.0,
                                          child: Column(
                                            children: [
                                              Icon(Icons.offline_pin, color: Colors.green, size: 40.0),
                                              SizedBox(width: 16.0),
                                              Container(
                                                margin: EdgeInsets.only(top: 15),
                                                child: Text(
                                                  'Purchased Successfully',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 25,
                                                    color: Color(0xFF3F3F57)
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin:EdgeInsets.only(top:15),
                                                height: 40,
                                                width: 100,
                                                child: ElevatedButton(
                                                  child: Text('Done'),
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>PolicyAlliance(),
                                                      ),
                                                    );
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                      backgroundColor: Color(0xFF07539D),
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.zero,
                                                      )
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        actions: [

                                        ],
                                      ),
                                    ),
                                  );
                                }else {

                                }
                              },
                              style: ElevatedButton.styleFrom( //<-- SEE HERE
                                  side: BorderSide(width:0.5,color: Color(0xFF07539D)),
                                  backgroundColor: Color(0xFF07539D),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero
                                  )
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),



              ],
            ),
          ),
        );
      },
      );

      },
    );
  }

  final companyDetails = Allcompanies();
  List<Company> companyList = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    Empty1 empty = await companyDetails.getCompany();
    setState(() {
      companyList = empty.company;
    });
  }
  num get StarIcons => 2;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:PreferredSize(
        preferredSize: Size.fromHeight(83.0),
        child: Container(
          width: double.infinity,
          child: AppBar(
            leading: Container(
              child: Container(child: Image.asset('assets/images/Group 18.jpg'),
                height: 150.0,
                width: 450.0,
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
                    width: 60.0,
                    height: 60.0,

                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.account_circle_outlined,
                        size: 37,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 100),
                    child: Text('Hi,'+widget.username,style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color: Color(0xFF07539D)),),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(child: SingleChildScrollView(
            child: Column(
              children: [Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children:[
                        Container(
                        height: 120,
                        width:double.infinity,
                        color: Color(0xFFFED662),
                      ),
                        Container(
                          margin: EdgeInsets.only(left: 300,top: 35),
                          child:SizedBox( // <-- SEE HERE
                            width: 700,
                            child:const TextField(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xFFFFFAED),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              keyboardType: TextInputType.name,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 310,top: 50),
                          child: Icon(Icons.search),
                        ),
                        Container(
                          height: 50,
                          width: 130,
                          margin: EdgeInsets.only(left: 1010,top:35),
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
                        )
                      ]
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 25,left: 34),
                      child: Text('Companies',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Color(0xFF07539D)),),
                    ),
                    SizedBox(
                      height: 350.0,
                      child: Container(
                        margin: EdgeInsets.only(top: 20),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                          companyList.length < 5 ? companyList.length : 5,
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left:34),
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

                                      width: 270,
                                      height: 350,
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: 299.0,
                                              height: 200,
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
                                              child: GestureDetector(
                                                onTap: () {
                                                  int companyId =
                                                      companyList[index].companyId;
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          companies(username: '',mobileNumber:widget.mobileNumber),
                                                    ),
                                                  );
                                                },
                                                child: ClipRRect(
                                                  borderRadius:
                                                  BorderRadius.circular(0),
                                                  child: Image.network(
                                                    companyList[index].companyImage,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 299.0,
                                              child: Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    margin:EdgeInsets.only(left:11),
                                                    child: Text(
                                                      companyList[index].companyName,
                                                      style: TextStyle(
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                        FontWeight.normal,
                                                        color: Color(0xFF0F1924),
                                                      ),
                                                    ),
                                                  ),

                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin:EdgeInsets.only(left:11),
                                              child: Text(
                                                companyList[index].plan,
                                                style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight:
                                                  FontWeight.normal,
                                                  color: Color(0xFF0F1924),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin:EdgeInsets.only(left:11,top: 7),
                                              child: Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  for (var i = 0; i < 5; i++)
                                                    Icon(
                                                      i <
                                                          (
                                                              companyList[index]
                                                                  .starRating)
                                                          ? Icons.star
                                                          : Icons.star_border,
                                                      color: i <
                                                          (
                                                              companyList[index]
                                                                  .starRating)
                                                          ? Color(0xFFF26F20)
                                                          : Color(0xFFF26F20),
                                                      size: 15,
                                                    ),
                                                  Container(
                                                    margin:
                                                    EdgeInsets.only(left: 106,top: 0),
                                                      child: OutlinedButton(
                                                        child: Text(companyList[index]
                                                            .premiumAmount, style: TextStyle(color: Color(0xFF07539D), fontSize: 10)),
                                                        onPressed: () {},
                                                        style: OutlinedButton.styleFrom(
                                                          side: BorderSide(color: Color(0xFF07539D)),
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.zero,
                                                          ),
                                                        ),
                                                      ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width:double.infinity,
                                              height:35,
                                              child: ElevatedButton(
                                                child: Text('Buy'),
                                                onPressed: () {
                                                          ShowOrderSummary(context, companyList[index]);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor: Color(0xFF07539D),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.zero,
                                                    )
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 500.0,
                      child: Container(
                        margin: EdgeInsets.only(top: 20),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                          companyList.length > 5 ? companyList.length - 5 : 0,
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 34),
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
                                      width: 270,
                                      height: 350,
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
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
                                            width: 299.0,
                                            height: 200.0,
                                            child: GestureDetector(
                                              onTap: () {
                                                int companyId =
                                                    companyList[index + 5].companyId;
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        companies(username: '',mobileNumber:widget.mobileNumber),
                                                  ),
                                                );
                                              },
                                              child: ClipRRect(
                                                borderRadius:
                                                BorderRadius.circular(10.0),
                                                child: Image.network(
                                                  companyList[index + 5]
                                                      .companyImage,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 299.0,
                                            child: Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  margin:EdgeInsets.only(left:11),
                                                  child: Text(
                                                    companyList[index + 5]
                                                        .companyName,
                                                    style: TextStyle(
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                      FontWeight.normal,
                                                      color: Color(0xFF0F1924),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin:EdgeInsets.only(left:11),
                                            child: Text(
                                              companyList[index].plan,
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                fontWeight:
                                                FontWeight.normal,
                                                color: Color(0xFF0F1924),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin:EdgeInsets.only(left:11,top: 7),
                                            child: Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                for (var i = 0; i < 5; i++)
                                                  Icon(
                                                    i <
                                                        (companyList[
                                                        index + 5]
                                                            .starRating)
                                                        ? Icons.star
                                                        : Icons.star_border,
                                                    color: i <
                                                        (companyList[
                                                        index + 5]
                                                            .starRating)
                                                        ? Color(0xFFF26F20)
                                                        : Color(0xFFF26F20),
                                                    size: 15,
                                                  ),
                                                Container(
                                                  margin:
                                                  EdgeInsets.only(left: 106),
                                                  child: OutlinedButton(
                                                    child: Text(companyList[index + 5]
                                                        .premiumAmount, style: TextStyle(color: Color(0xFF07539D), fontSize: 10)),
                                                    onPressed: () {},
                                                    style: OutlinedButton.styleFrom(
                                                      side: BorderSide(color: Color(0xFF07539D)),
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.zero,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width:double.infinity,
                                            height:35,
                                            child: ElevatedButton(
                                              child: Text('Buy'),
                                              onPressed: () {
                                                ShowOrderSummary(context, companyList[index]);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: Color(0xFF07539D),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.zero,
                                                  )
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),

                  ],
                ),
              ),],
            ),
          ),
          )

        ],
      ),

    );
  }
}
