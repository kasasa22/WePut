import 'package:flutter/material.dart';

class TaskListItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isCompleted;

  TaskListItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isCompleted,
  });
}

class TasksList extends StatelessWidget {
  final List<TaskListItem> tasks;

  const TasksList({Key? key, required this.tasks, required String taskName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        var taskData = tasks[index];
        return ListTile(
          leading: Icon(taskData.icon),
          title: Text(taskData.title),
          subtitle: Text(taskData.subtitle),
          trailing: Checkbox(
            value: taskData.isCompleted,
            onChanged: (bool? value) {
              // Handle task completion status change here
            },
          ),
          onTap: () {
            // Handle tapping on the task item here
          },
        );
      },
    );
  }
}
