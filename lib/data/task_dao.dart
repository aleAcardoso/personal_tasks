import 'package:personal_tasks/components/task.dart';
import 'package:personal_tasks/data/database.dart';
import 'package:sqflite/sqflite.dart';

class TaskDao {
  static const String taskTable = 'CREATE TABLE $_table('
      '$_id TEXT, '
      '$_name TEXT, '
      '$_difficulty INTEGER, '
      '$_image TEXT, '
      '$_level INTEGER,'
      '$_mastery INTEGER,'
      '$_totalLevel INTEGER)';

  static const String _table = 'taskTable';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _difficulty = 'difficulty';
  static const String _image = 'image';
  static const String _level = 'level';
  static const String _mastery = 'mastery';
  static const String _totalLevel = 'totalLevel';

  save(Task task) async {
    final Database db = await getDatabase();
    var itemExists = await findById(task.id);
    if (itemExists.isEmpty) {
      return await db.insert(_table, taskToMap(task));
    } else {
      return await db.update(_table, taskToMap(task),
          where: '$_id = ?', whereArgs: [task.id]);
    }
  }

  Future<List<Task>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> tasksMap = await db.query(_table);
    return toTaskList(tasksMap);
  }

  Future<List<Task>> findById(String taskId) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> tasksMap =
        await db.query(_table, where: '$_id = ?', whereArgs: [taskId]);
    return toTaskList(tasksMap);
  }

  Future<List<Task>> find(String taskName) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> tasksMap =
        await db.query(_table, where: '$_name = ?', whereArgs: [taskName]);
    return toTaskList(tasksMap);
  }

  delete(String taskId) async {
    final Database db = await getDatabase();
    return db.delete(_table, where: '$_id = ?', whereArgs: [taskId]);
  }

  Future<double> get levelSum async {
    double levelSum = 0;
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> tasksMap = await db.query(_table);
    final taskList = toTaskList(tasksMap);
    for(var task in taskList) {
      levelSum += (task.totalLevel * task.difficulty)/10;
    }
    return levelSum.roundToDouble();
  }

  Future<double> get difficultySum async {
    double difficulty = 0;
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> tasksMap = await db.query(_table);
    final taskList = toTaskList(tasksMap);
    for(var task in taskList) {
      difficulty += (task.difficulty * 10);
    }
    return difficulty.roundToDouble();
  }

  Future<double> get globalProgress async {
    double globalProgress = 0;

    levelSum.then((level) {
      difficultySum.then((difficulty) {
        globalProgress = level/difficulty;
      });
    });

    return globalProgress.roundToDouble();
  }

  List<Task> toTaskList(List<Map<String, dynamic>> mapList) {
    final List<Task> tasks = [];
    for (Map<String, dynamic> map in mapList) {
      tasks.add(mapToTask(map));
    }
    return tasks;
  }

  Task mapToTask(Map<String, dynamic> map) =>
      Task(
          map[_id],
          map[_name],
          map[_image],
          map[_difficulty],
          level: map[_level],
          mastery: map[_mastery],
          totalLevel: map[_totalLevel]
      );

  Map<String, dynamic> taskToMap(Task task) => {
        _id: task.id,
        _name: task.name,
        _image: task.photo,
        _difficulty: task.difficulty,
        _level: task.level,
        _mastery: task.mastery,
        _totalLevel: task.totalLevel
      };
}
