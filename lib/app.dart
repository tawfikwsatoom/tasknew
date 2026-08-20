import 'package:flutter/material.dart';
import 'Screens/dashboard_screen.dart';

class TaskatiApp extends StatelessWidget {
  const TaskatiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Taskati',
      home: const DashboardScreen(),
    );
  }
}