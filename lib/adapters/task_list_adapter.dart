import 'package:flutter/material.dart';

import '../models/task.dart';

class TaskListExpandAdapter {
  List? tasks = <Task>[];
  List<Widget> taskTiles = [];

  TaskListExpandAdapter(this.tasks) {
    for (int i = 0; i < tasks!.length; i++) {
      taskTiles.add(TaskTile(index: i, task: tasks![i]));
    }
  }

  List<Widget> getView() {
    return taskTiles;
  }
}

class TaskTile extends StatefulWidget {
  final int index;
  final Task task;

  const TaskTile({
    Key? key,
    required this.index,
    required this.task,
  }) : super(key: key);

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        width: 50,
        height: 50,
        child: CircleAvatar(
          backgroundColor: Colors.blue, // Customize the color as needed
          child: Text(
            widget.task.title.substring(0, 1).toUpperCase(),
            style: TextStyle(
              color: Colors.grey[880],
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      title: Text(
        widget.task.title,
        style: TextStyle(
          color: Colors.grey[880],
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Due Date: ${widget.task.dueDate.toDate()}',
            style: TextStyle(
              color: Colors.grey[880],
            ),
          ),
          Text(
            'Status: ${widget.task.status}',
            style: TextStyle(
              color: Colors.grey[880],
            ),
          ),
          Text(
            'Assigned User: ${widget.task.assignedUserId}',
            style: TextStyle(
              color: Colors.grey[880],
            ),
          ),
          // Add more details as needed
        ],
      ),
      onTap: () {
        // Handle tile tap if needed
      },
    );
  }
}
