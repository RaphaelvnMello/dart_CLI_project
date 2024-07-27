import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:students_manager_cli/scr/models/course.dart';

class ProductRepository {
  Future<Course> findByName(String name) async {
    final response =
        await http.get(Uri.parse('http://localhost:8080/products?name=$name'));
    if (response.statusCode != 200) {
      throw Exception();
    }

    final List<Map<String, dynamic>> responseData = jsonDecode(response.body);
    if (responseData.isEmpty) {
      throw Exception("The product does not exist");
    }
    final courses = Course.fromMap(responseData.first);
    return courses;
  }
}
