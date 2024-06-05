import 'package:personal_tasks/components/task.dart';
import 'package:personal_tasks/data/database.dart';
import 'package:sqflite/sqflite.dart';

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

  Future<List<Task>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> tasksMap = await db.query(_tableName);
    return toTaskList(tasksMap);
  }

  Future<List<Task>> find(String taskName) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> tasksMap =
        await db.query(_tableName, where: '$_name = ?', whereArgs: [taskName]);
    return toTaskList(tasksMap);
  }

  delete(String taskName) async {}

  List<Task> toTaskList(List<Map<String, dynamic>> mapList) {
    final List<Task> tasks = [];
    for (Map<String, dynamic> map in mapList) {
      tasks.add(mapToTask(map));
    }
    return tasks;
  }

  Task mapToTask(Map<String, dynamic> map) =>
      Task(map[_name], map[_image], map[_difficulty]);
}
