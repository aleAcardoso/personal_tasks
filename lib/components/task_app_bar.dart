import 'package:flutter/material.dart';
import 'package:personal_tasks/data/task_inherited.dart';

class TaskAppBar extends StatefulWidget {
  const TaskAppBar({super.key});

  @override
  State<TaskAppBar> createState() => _TaskAppBarState();
}

class _TaskAppBarState extends State<TaskAppBar> {

  double globalLevel = 0.0;
  double levelSum = 0.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tarefas',
              style: TextStyle(color: Colors.white),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: SizedBox(
                    width: 225,
                    child: LinearProgressIndicator(
                      value: globalLevel,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  'Level: $levelSum',
                  style: const TextStyle(color: Colors.white, fontSize: 16,),
                )
              ],
            )
          ],
        ),
        IconButton(
          onPressed: (){
            setState(() {
              globalLevel = TaskInherited.of(context).globalProgress;
              levelSum = TaskInherited.of(context).levelSum;
            });
          },
          icon: const Icon(
            Icons.refresh,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
