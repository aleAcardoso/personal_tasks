import 'package:flutter/material.dart';
import 'package:personal_tasks/data/task_dao.dart';

class TaskAppBar extends StatefulWidget {
  const TaskAppBar(this.onRefreshButtonClicked, {super.key});

  final VoidCallback onRefreshButtonClicked;

  @override
  State<TaskAppBar> createState() => _TaskAppBarState();
}

class _TaskAppBarState extends State<TaskAppBar> {

  double globalLevel = 0.0;
  double levelSum = 0.0;

  @override
  void initState() {
    super.initState();
    calculateProgress();
  }

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
                    width: 180,
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
            calculateProgress();
            widget.onRefreshButtonClicked();
          },
          icon: const Icon(
            Icons.refresh,
            color: Colors.white,
          ),
        )
      ],
    );
  }

  void calculateProgress() {
    setState(() {
      TaskDao().levelSum.then((level) {
        TaskDao().globalProgress.then((global) {
          globalLevel = global;
          levelSum = level;
        });
      });
    });
  }
}
