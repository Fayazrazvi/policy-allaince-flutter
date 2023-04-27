import 'dart:convert';
import 'package:http/http.dart' as http;
import '../modal/companies-modal.dart';

class Allcompanies {
  Future<Empty1> getCompany() async {

    final response = await http.post(
      Uri.parse('http://localhost:8080/home/company'),
      headers: {
        'Content-Type': 'application/json',
      },

    );
    if (response.statusCode == 200) {
      print('Fayaz');
      return Empty1.fromJson(jsonDecode(response.body));
    } else {
      print('error');
      throw Exception('Failed to fetch movies');
    }
  }
}