import 'package:flutter/material.dart';
import 'package:maker/models/task.dart';
import '../services/task.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  final TaskService taskService = TaskService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CRUD Test'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _tasksListView(),
          ],
        ),
      ),
    );
  }

  Widget _tasksListView() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width * 0.8,
      child: StreamBuilder(
        stream: taskService.getTasks(),
        builder: (context, snapshot) {
          List tasks = snapshot.data?.docs ?? [];

          if (tasks.isEmpty) {
            return const Center(
              child: Text('No tasks found'),
            );
          }
          // print(tasks.length);

          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (contex, index) {
              Task task = tasks[index].data();
              // ignore: avoid_print, prefer_interpolation_to_compose_strings
              print("the key is " + tasks[index].id);
              String key = tasks[index].id;

              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: ListTile(
                  tileColor: Colors.amber,
                  title: Text(task.title),
                  subtitle: Text(key),
                  trailing: Checkbox(
                    value: false,
                    onChanged: (value) {
                      Task updateTask = task.copyWith();
                      taskService.updateTask(key, updateTask);
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
