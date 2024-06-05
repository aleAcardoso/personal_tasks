import 'package:personal_tasks/components/task.dart';

class TaskDao {
  static const String taskTable = 'CREATE TABLE $_tableName('
      '$_name TEXT, '
      '$_difficulty INTEGER, '
      '$_image TEXT)';

  static const String _tableName = 'taskTable';
  static const String _name = 'name';
  static const String _difficulty = 'difficulty';
  static const String _image = 'image';

  save(Task task) async {}

  Future<List<Task>> findAll() async {}

  Future<List<Task>> find(String taskName) async {}

  delete(String taskName) async {}
}
