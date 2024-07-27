import 'package:args/command_runner.dart';
import 'package:students_manager_cli/scr/commands/students/students_command.dart';

void main(List<String> arguments) {
  CommandRunner("Studants Manager", "description")
    ..addCommand(StudentsCommand())
    ..run(arguments);
}
