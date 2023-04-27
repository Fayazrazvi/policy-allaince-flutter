import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:policyalliance/modal/customers-modal.dart';
import '../modal/companies-modal.dart';

class Allcustomers {
  Future<Empty2> getCustomer() async {

    final response = await http.post(
      Uri.parse('http://localhost:8080/home/customers'),
      headers: {
        'Content-Type': 'application/json',
      },

    );
    if (response.statusCode == 200) {
      print('Fayaz naruto');
      return Empty2.fromJson(jsonDecode(response.body));
    } else {
      print('error');
      throw Exception('Failed to fetch movies');
    }
  }
}