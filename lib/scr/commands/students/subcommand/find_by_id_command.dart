import 'package:args/command_runner.dart';
import 'package:students_manager_cli/scr/repositories/student_repository.dart';

class FindByIdCommand extends Command {
  final StudentRepository studentRepository;
  @override
  String get description => 'Find Student By Id ';

  @override
  String get name => 'byId';

  FindByIdCommand({required this.studentRepository}) {
    argParser.addOption('id', help: 'Student Id', abbr: 'i');
  }

  @override
  Future<void> run() async {
    if (argResults?['id'] == null) {
      print('Please, send the student id with command --id or -i');
      return;
    }

    final id = int.parse(argResults?['id']);

    print('Searching student...');
    final student = await StudentRepository().findById(id);
    print("The student is ${student.name}");
    print("The student age is: ${student.age ?? 'age not given'}");
    print("The student id is ${student.id}");
    student.nameCourses.forEach(print);
    print(
        "The student adress is: street: ${student.address.street}, zipcode: ${student.address.zipCode}");
  }
}
