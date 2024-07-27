import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:students_manager_cli/scr/models/Phone.dart';
import 'package:students_manager_cli/scr/models/address.dart';
import 'package:students_manager_cli/scr/models/city.dart';
import 'package:students_manager_cli/scr/models/course.dart';

import 'package:students_manager_cli/scr/models/students.dart';
import 'package:students_manager_cli/scr/repositories/product_repository.dart';
import 'package:students_manager_cli/scr/repositories/student_repository.dart';

class UpdateCommand extends Command {
  StudentRepository studentRepository;
  final productRepository = ProductRepository();

  @override
  String get description => 'Update Student';

  @override
  String get name => "update";

  UpdateCommand({required this.studentRepository}) {
    argParser.addOption('file', help: 'Path of the csv file', abbr: 'f');
    argParser.addOption('id', help: 'student ID', abbr: 'i');
  }

  @override
  Future<void> run() async {
    print('wait ...');
    final filePath = argResults?['file'];
    final id = argResults?['id'];

    if (id == null) {
      return;
    }

    final students = File(filePath).readAsLinesSync();
    print('-----------------------------------------');

    if (students.length > 1) {
      return;
    } else if (students.isEmpty) {
      return;
    }

    var student = students.first;

    final studentData = student.split(';');
    final courseCSV = studentData[2].split(',').map((e) => e.trim()).toList();

    final courseFuture = courseCSV.map((c) async {
      final Course course = await productRepository.findByName(c);
      course.isStudent = true;
      return course;
    }).toList();

    final List<Course> courses = await Future.wait(courseFuture);

    final studentModel = Student(
        id: int.parse(id),
        name: studentData[0],
        age: int.tryParse(studentData[1]),
        nameCourses: courseCSV,
        courses: courses,
        address: Address(
            street: studentData[3],
            number: int.parse(studentData[4]),
            zipCode: studentData[5],
            city: City(id: 1, name: studentData[6]),
            phone: Phone(
              ddd: int.parse(studentData[7]),
              phone: studentData[8],
            )));

    await studentRepository.update(studentModel);

    print('Students update successfull');
  }
}
