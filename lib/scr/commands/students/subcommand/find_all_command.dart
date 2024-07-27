import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:students_manager_cli/scr/repositories/student_repository.dart';

class FindAllCommand extends Command {
  final StudentRepository studentRepository;
  FindAllCommand({required this.studentRepository});
  @override
  String get description => 'Find All Students';

  @override
  String get name => 'findAll';

  @override
  Future<void> run() async {
    print('Finding All Students...');
    final students = await studentRepository.findAll();
    print("You also want to show the courses? (Y/N)");
    final showCourses = stdin.readLineSync();
    for (var student in students) {
      if (showCourses?.toLowerCase() == "y") {
        print("student: ${student.name}, courses: ${student.courses}");
      } else {
        print("student: ${student.name}");
      }
    }
  }
}
