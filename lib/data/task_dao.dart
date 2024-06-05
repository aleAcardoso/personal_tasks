import 'package:personal_tasks/components/task.dart';
import 'package:personal_tasks/data/database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

class TaskDao {
  static const String taskTable = 'CREATE TABLE $_tableName('
      '$_id TEXT, '
      '$_name TEXT, '
      '$_difficulty INTEGER, '
      '$_image TEXT)';

  static const String _tableName = 'taskTable';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _difficulty = 'difficulty';
  static const String _image = 'image';

  save(Task task) async {
    final Database db = await getDatabase();
    var itemExists = await find(task.name);
    if (itemExists.isEmpty) {
      return await db.insert(_tableName, taskToMap(task));
    } else {
      return await db.update(_tableName, taskToMap(task),
          where: '$_name = ?', whereArgs: [task.name]);
    }
  }

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

  delete(String taskName) async {
    final Database db = await getDatabase();
    return db.delete(_tableName, where: '$_name = ?', whereArgs: [taskName]);
  }

  List<Task> toTaskList(List<Map<String, dynamic>> mapList) {
    final List<Task> tasks = [];
    for (Map<String, dynamic> map in mapList) {
      tasks.add(mapToTask(map));
    }
    return tasks;
  }

  Task mapToTask(Map<String, dynamic> map) =>
      Task(map[_id], map[_name], map[_image], map[_difficulty]);

  Map<String, dynamic> taskToMap(Task task) => {
        _id: task.id,
        _name: task.name,
        _image: task.photo,
        _difficulty: task.difficulty
      };
}
