import 'package:flutter/material.dart';
import 'package:personal_tasks/components/custom_alert_dialog.dart';
import 'package:personal_tasks/data/task_dao.dart';
import 'difficulty.dart';

class Task extends StatefulWidget {
  String id;
  String name;
  String photo;
  int difficulty;

  Task(this.id, this.name, this.photo, this.difficulty,
      {this.level = 0, this.mastery = 1, this.totalLevel = 0, super.key});

  int level;
  int mastery;
  int totalLevel;

  double get progressCalculation => ((level / mastery) / difficulty) / 10;

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  bool assetOrNetwork() {
    if (widget.photo.contains('http')) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: setProgressBarBackgroundColor()),
            height: 140,
          ),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.black26,
                      ),
                      width: 72,
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: assetOrNetwork()
                            ? Image.asset(
                                widget.photo,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                widget.photo,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 200,
                          child: Text(
                            widget.name,
                            style: const TextStyle(
                                fontSize: 24, overflow: TextOverflow.ellipsis),
                          ),
                        ),
                        Difficulty(
                          difficultyLevel: widget.difficulty,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 64,
                      width: 64,
                      child: ElevatedButton(
                          onLongPress: () {
                            showDialog(
                                context: context,
                                builder: (context) => CustomAlertDialog(
                                    title: 'Deseja deletar esta tarefa?',
                                    primaryButtonText: 'Sim, deletar',
                                    secondaryButtonText: 'Não, cancelar',
                                    onPrimaryButtonClicked: () {
                                      TaskDao().delete(widget.id);
                                    }));
                          },
                          onPressed: () {
                            setState(() {
                              if (widget.progressCalculation != 1) {
                                widget.level++;
                                widget.totalLevel++;
                                TaskDao().save(Task(
                                  widget.id,
                                  widget.name,
                                  widget.photo,
                                  widget.difficulty,
                                  level: widget.level,
                                  mastery: widget.mastery,
                                  totalLevel: widget.totalLevel
                                ));
                              } else if (widget.mastery < 5) {
                                widget.mastery++;
                                widget.level = 0;
                              }
                            });
                          },
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Icon(Icons.arrow_drop_up),
                              Text(
                                'UP',
                                style: TextStyle(fontSize: 12),
                              )
                            ],
                          )),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        width: 200,
                        child: LinearProgressIndicator(
                          color: Colors.white,
                          value: (widget.difficulty > 0)
                              ? widget.progressCalculation
                              : 1,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Nivel: ${widget.level}',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  MaterialColor setProgressBarBackgroundColor() => switch (widget.mastery) {
        1 => Colors.blue,
        2 => Colors.green,
        3 => Colors.pink,
        4 => Colors.purple,
        _ => Colors.amber
      };
}
