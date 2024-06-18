import 'package:flutter/material.dart';
import 'package:personal_tasks/data/task_inherited.dart';
import 'package:personal_tasks/routes/app_routes.dart';
import 'package:personal_tasks/screens/form_screen.dart';
import 'screens/initial_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return TaskInherited(
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
          useMaterial3: true,
        ),
        initialRoute: '/initial_screen',
        routes: {
          AppRoutes.initialScreen.route: (context) => const InitialScreen(),
          AppRoutes.formScreen.route: (context) => FormScreen(context)
        },
      ),
    );
  }
}
