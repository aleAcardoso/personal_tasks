import 'package:flutter/material.dart';
import 'package:personal_tasks/components/loading_widget.dart';
import 'package:personal_tasks/components/task.dart';
import 'package:personal_tasks/components/task_app_bar.dart';
import 'package:personal_tasks/data/task_dao.dart';
import 'package:personal_tasks/data/task_inherited.dart';
import 'package:personal_tasks/routes/app_routes.dart';

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
        backgroundColor: Colors.blue,
        title: TaskAppBar(
          () {
            setState(() {});
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: FutureBuilder<List<Task>>(
            future: TaskDao().findAll(),
            builder: (context, snapshot) {
              List<Task>? items = snapshot.data;
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return const LoadingWidget();
                case ConnectionState.waiting:
                  return const LoadingWidget();
                case ConnectionState.active:
                  return const LoadingWidget();
                case ConnectionState.done:
                  if (snapshot.hasData && items != null) {
                    if (items.isNotEmpty) {
                      return ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (BuildContext context, int index) {
                            return items[index];
                          });
                    }
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 128,
                          ),
                          Text(
                            'Nãe há nenhuma tarefa',
                            style: TextStyle(fontSize: 32),
                          )
                        ],
                      ),
                    );
                  }
                  return const Text('Erro ao carregar tarefas');
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.of(context)
              .pushNamed(AppRoutes.formScreen.route)
              .then((value) => setState(() {}));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
