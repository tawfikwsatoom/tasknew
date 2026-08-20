import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CompletedScreen extends StatelessWidget {
  const CompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('tasks_box');

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Completed Tasks',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box box, _) {
          final tasks = <MapEntry<dynamic, dynamic>>[];

          for (final key in box.keys) {
            final value = box.get(key);

            if (value is Map && value['completed'] == true) {
              tasks.add(
                MapEntry(key, value),
              );
            }
          }

          if (tasks.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.done_all,
                    size: 90,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No completed tasks',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final entry = tasks[index];

              final key = entry.key;
              final task = Map<String, dynamic>.from(entry.value);

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: Checkbox(
                    value: true,
                    onChanged: (_) {
                      task['completed'] = false;
                      box.put(key, task);
                    },
                  ),
                  title: Text(
                    task['title'] ?? '',
                    style: const TextStyle(
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  subtitle: Text(
                    task['date'] ?? '',
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      box.delete(key);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}