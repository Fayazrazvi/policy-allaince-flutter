import 'package:flutter/material.dart';
import 'package:policyalliance/api/customer-api.dart';
import 'package:policyalliance/modal/customers-modal.dart';



class customers extends StatefulWidget {
  @override
  State<customers> createState() => _customersState();
}

class _customersState extends State<customers> {

  final customerDetails = Allcustomers();
  List<Customer> customerList = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    Empty2 empty = await customerDetails.getCustomer();
    setState(() {
      customerList = empty.customer;
    });
  }
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
              Container(
                margin: EdgeInsets.only(top: 30),
                child: Text('Customers',style: TextStyle(color: Color(0xFF07539D),fontSize: 20,decoration: TextDecoration.underline,fontWeight: FontWeight.bold),),
              ),
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
                    child: Text('Hi,Fayaz',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color: Color(0xFF07539D)),),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      body:  Column(
        children: [
          Expanded(child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
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
                            margin: EdgeInsets.only(left: 300, top: 35),
                            child: SizedBox(
                              width: 700,
                              child: TextField(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xFFFFFAED),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  hintText: '',
                                  prefixIcon: Icon(Icons.search),
                                ),
                                keyboardType: TextInputType.name,
                              ),
                            ),
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
                  ],
                ),
              ),
                SizedBox(
                  height: 350.0,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: [
                        DataColumn(label: Text('PaymentId')),
                        DataColumn(label: Text('Name')),
                        DataColumn(label: Text('MobileNumber')),
                        DataColumn(label: Text('Plan')),
                        DataColumn(label: Text('Payment Via')),
                        DataColumn(label: Text('Policy Start Date')),
                        DataColumn(label: Text('Policy End Date')),
                        DataColumn(label: Text('Company Name')),
                        DataColumn(label: Text('Premium Amount')),
                      ],
                      rows: customerList.map((customer) => DataRow(
                        cells: [
                          DataCell(Text(customer.paymentId.toString())),
                          DataCell(Text(customer.name)),
                          DataCell(Text(customer.mobileNumber.toString())),
                          DataCell(Text(customer.plan)),
                          DataCell(Text(customer.paymentVia)),
                          DataCell(Text(customer.policyStartDate)),
                          DataCell(Text(customer.policyEndDate)),
                          DataCell(Text(customer.companyName)),
                          DataCell(Text(customer.premiumAmount)),
                        ],
                      )).toList(),
                    ),
                  ),
                ),


              ],
            ),
          ))

        ],
      ),


    );
  }
}
