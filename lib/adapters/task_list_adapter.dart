import 'package:flutter/material.dart';

import '../models/task.dart';

class TaskTile extends StatefulWidget {
  final int index;
  final Task task;
  final Color? leadingColor; // Color for the leading avatar
  final VoidCallback? onComplete; // Callback when task is marked as complete
  final VoidCallback? onAddPeople; // Callback for adding people

  const TaskTile({
    Key? key,
    required this.index,
    required this.task,
    this.leadingColor, // Optional leading avatar color
    this.onComplete, // Optional completion callback
    this.onAddPeople, // Optional add people callback
  }) : super(key: key);

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  String getFormattedDate(DateTime date) {
    // Helper method to format DateTime to a readable string
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        width: 50,
        height: 50,
        child: CircleAvatar(
          backgroundColor: widget.leadingColor ?? Colors.blue,
          child: Text(
            widget.task.title.substring(0, 1).toUpperCase()!,
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
          Divider(
            color: Colors.grey[880],
            thickness: 1,
          ),
          Text(
            widget.task.description,
            maxLines: 2,
            style: TextStyle(
              color: Colors.grey[880],
            ),
          ),
          Text(
            'Priority: ${widget.task.priority}',
            style: TextStyle(
              color: Colors.grey[880],
              fontSize: 10,
            ),
          ),
          Text(
            'Due Date: ${getFormattedDate(widget.task.dueDate.toDate())}',
            style: TextStyle(
              color: Colors.grey[880],
              fontSize: 10,
            ),
          ),
          // Add more details as needed
        ],
      ),
      trailing: widget.task.status != 'Completed'
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.check,
                    color: Colors.green,
                    size: 30,
                  ),
                  onPressed: () {
                    if (widget.onComplete != null) {
                      widget.onComplete!();
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.person_add,
                    color: Colors.blue,
                    size: 30,
                  ),
                  onPressed: () {
                    if (widget.onAddPeople != null) {
                      widget.onAddPeople!();
                    }
                  },
                ),
              ],
            )
          : null,
      onTap: () {
        // Handle tile tap if needed
      },
    );
  }
}
