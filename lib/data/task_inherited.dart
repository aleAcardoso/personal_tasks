import 'package:flutter/material.dart';
import 'package:personal_tasks/components/task.dart';
import 'package:uuid/uuid.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({
    super.key,
    required super.child,
  });

  final List<Task> taskList = [
    Task(const Uuid().v1(), 'Aprender Flutter', 'assets/images/dash.png', 3),
    Task(const Uuid().v1(), 'Andar de Bike', 'assets/images/bike.webp', 2),
    Task(const Uuid().v1(), 'Meditar', 'assets/images/meditar.jpeg', 5),
    Task(const Uuid().v1(), 'Ler', 'assets/images/livro.jpg', 4),
    Task(const Uuid().v1(), 'Jogar', 'assets/images/jogar.jpg', 1),
  ];

  void newTask(String name, String photo, int difficulty) {
    taskList.add(Task(const Uuid().v1(), name, photo, difficulty));
  }

  double get levelSum {
    double levelSum = 0;

    for (var task in taskList) {
      levelSum += (task.totalLevel * task.difficulty)/10;
    }

    return levelSum.roundToDouble();
  }

  double get difficultySum {
    double difficultySum = 0;

    for (var task in taskList) {
      difficultySum += (task.difficulty * 10);
    }

    return difficultySum.roundToDouble();
  }

  double get globalProgress => (levelSum/difficultySum).roundToDouble();

  static TaskInherited of(BuildContext context) {
    final TaskInherited? result =
        context.dependOnInheritedWidgetOfExactType<TaskInherited>();
    assert(result != null, 'No TaskInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(TaskInherited oldWidget) {
    return oldWidget.taskList.length != taskList.length;
  }
}
