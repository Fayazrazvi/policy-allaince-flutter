// To parse this JSON data, do
//
//     final empty2 = empty2FromJson(jsonString);

import 'dart:convert';

Empty2 empty2FromJson(String str) => Empty2.fromJson(json.decode(str));

String empty2ToJson(Empty2 data) => json.encode(data.toJson());

class Empty2 {
  Empty2({
    required this.customer,
  });

  List<Customer> customer;

  factory Empty2.fromJson(Map<String, dynamic> json) => Empty2(
    customer: List<Customer>.from(json["customer"].map((x) => Customer.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "customer": List<dynamic>.from(customer.map((x) => x.toJson())),
  };
}

class Customer {
  Customer({
    required this.plan,
    required this.paymentVia,
    required this.policyEndDate,
    required this.policyStartDate,
    required this.paymentId,
    required this.name,
    required this.premiumAmount,
    required this.mobileNumber,
    required this.companyName,
  });

  String plan;
  String paymentVia;
  String policyEndDate;
  String policyStartDate;
  int paymentId;
  String name;
  String premiumAmount;
  int mobileNumber;
  String companyName;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    plan: json["plan"]?? '',
    paymentVia: json["payment_via"]?? '',
    policyEndDate: json["policy_end_date"]?? '',
    policyStartDate: json["policy_start_date"]?? '',
    paymentId: json["payment_id"]?? '',
    name: json["name"]?? '',
    premiumAmount: json["premium_amount"]?? '',
    mobileNumber: json["mobile_number"]?? '',
    companyName: json["company_name"]?? '',
  );

  Map<String, dynamic> toJson() => {
    "plan": plan,
    "payment_via": paymentVia,
    "policy_end_date": policyEndDate,
    "policy_start_date": policyStartDate,
    "payment_id": paymentId,
    "name": name,
    "premium_amount": premiumAmount,
    "mobile_number": mobileNumber,
    "company_name": companyName,
  };
}
