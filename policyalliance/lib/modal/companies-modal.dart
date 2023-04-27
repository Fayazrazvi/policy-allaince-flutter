// To parse this JSON data, do
//
//     final empty1 = empty1FromJson(jsonString);

import 'dart:convert';

Empty1 empty1FromJson(String str) => Empty1.fromJson(json.decode(str));

String empty1ToJson(Empty1 data) => json.encode(data.toJson());

class Empty1 {
  Empty1({
    required this.company,
  });

  List<Company> company;

  factory Empty1.fromJson(Map<String, dynamic> json) => Empty1(
    company: List<Company>.from(json["company"].map((x) => Company.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "company": List<dynamic>.from(company.map((x) => x.toJson())),
  };
}

class Company {
  Company({
    required this.plan,
    required this.companyName,
    required this.companyImage,
    required this.starRating,
    required this.premiumAmount,
    required this.userId,
    required this.companyId,
  });

  String plan;
  String companyName;
  String companyImage;
  int starRating;
  String premiumAmount;
  int userId;
  int companyId;

  factory Company.fromJson(Map<String, dynamic> json) => Company(
    plan: json["plan"] ?? '',
    companyName: json["company_name"] ?? '',
    companyImage: json["company_image"] ?? '',
    starRating: json["star_rating"] ?? '',
    premiumAmount: json["premium_amount"] ?? '',
    userId: json["user_id"] ?? '',
    companyId: json["company_id"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "plan": plan,
    "company_name": companyName,
    "company_image": companyImage,
    "star_rating": starRating,
    "premium_amount": premiumAmount,
    "user_id": userId,
    "company_id": companyId,
  };
}

enum Plan { BASE_PLAN }

final planValues = EnumValues({
  "Base Plan": Plan.BASE_PLAN
});

enum PremiumAmount { THE_1500_PM, THE_1000_PM, THE_500_PM }

final premiumAmountValues = EnumValues({
  "\u00241000/pm": PremiumAmount.THE_1000_PM,
  "\u00241500/pm": PremiumAmount.THE_1500_PM,
  "\u0024500/pm": PremiumAmount.THE_500_PM
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
