import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:students_manager_cli/scr/models/students.dart';

class StudentRepository {
  Future<List<Student>> findAll() async {
    final response =
        await http.get(Uri.parse("http://localhost:8080/students"));

    if (response.statusCode != 200) {
      throw Exception();
    }

    final List<dynamic> responseData = jsonDecode(response.body);

    if (responseData.isEmpty) {
      throw Exception("There are no registered student");
    }

    final students = responseData.map((e) => Student.fromMap(e)).toList();

    return students;
  }

  Future<Student> findById(int id) async {
    final response =
        await http.get(Uri.parse("http://localhost:8080/students/$id"));

    if (response.statusCode != 200) {
      throw Exception();
    }

    if (response.body.isEmpty) {
      throw Exception("There are no registered student");
    }

    return Student.fromJson(response.body);
  }

  Future<void> insert(Student student) async {
    final response = await http.post(
        Uri.parse("http://localhost:8080/students"),
        body: student.toJson(),
        headers: {
          'content-type': 'application/json',
        });

    if (response.statusCode != 200) {
      throw Exception();
    }
  }

  Future<void> update(Student student) async {
    final response = await http.put(
        Uri.parse("http://localhost:8080/students/${student.id}"),
        body: student.toJson(),
        headers: {
          'content-type': 'application/json',
        });

    if (response.statusCode != 200) {
      throw Exception();
    }
  }

  Future<void> delete(int id) async {
    final response =
        await http.delete(Uri.parse("http://localhost:8080/students/$id"));

    if (response.statusCode != 200) {
      throw Exception();
    }
  }
}
