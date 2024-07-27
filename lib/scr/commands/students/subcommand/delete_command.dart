import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:students_manager_cli/scr/repositories/student_repository.dart';

class DeleteCommand extends Command {
  final StudentRepository studentRepository;
  DeleteCommand({required this.studentRepository}) {
    argParser.addOption('id', help: 'id student', abbr: 'i');
  }

  @override
  String get description => 'Delete Student';

  @override
  String get name => 'delete';

  Future<void> run() async {
    final id = int.tryParse(argResults?['id']);

    if (id == null) {
      print('Please, send the student id with command --id or -i');
      return;
    }

    print('delete student...');
    final student = await studentRepository.findById(id);

    print("Do you want to delete the student ${student.name} - id: $id? (Y/N)");
    final deleteStudent = stdin.readLineSync();

    if (deleteStudent?.toLowerCase() == 'y') {
      await studentRepository.delete(id);
      print('student delete successfull');
    } else {
      print("Deleting proccess stopped");
    }
  }
}
