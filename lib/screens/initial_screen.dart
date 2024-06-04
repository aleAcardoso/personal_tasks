import 'package:flutter/material.dart';
import 'package:personal_tasks/data/task_inherited.dart';
import 'package:personal_tasks/screens/form_screen.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: const Text('Tarefas'),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 80),
        children: TaskInherited.of(context).taskList,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => FormScreen(context))
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
