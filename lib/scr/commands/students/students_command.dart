import 'package:args/command_runner.dart';
import 'package:students_manager_cli/scr/commands/students/subcommand/delete_command.dart';
import 'package:students_manager_cli/scr/commands/students/subcommand/find_all_command.dart';
import 'package:students_manager_cli/scr/commands/students/subcommand/find_by_id_command.dart';
import 'package:students_manager_cli/scr/commands/students/subcommand/insert_command.dart';
import 'package:students_manager_cli/scr/commands/students/subcommand/update_command.dart';
import 'package:students_manager_cli/scr/repositories/student_repository.dart';

class StudentsCommand extends Command {
  @override
  String get description => 'Students Operations';

  @override
  String get name => 'Students';

  StudentsCommand() {
    final repository = StudentRepository();
    addSubcommand(FindAllCommand(studentRepository: repository));
    addSubcommand(FindByIdCommand(studentRepository: repository));
    addSubcommand(InsertCommand(studentRepository: repository));
    addSubcommand(UpdateCommand(studentRepository: repository));
    addSubcommand(DeleteCommand(studentRepository: repository));
  }
}
