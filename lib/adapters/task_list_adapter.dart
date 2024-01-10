import 'package:flutter/material.dart';

import '../models/task.dart';

class TaskTile extends StatefulWidget {
  final int index;
  final Task task;
  final Color? leadingColor; // Color for the leading avatar
  final VoidCallback? onComplete; // Callback when task is marked as complete

  const TaskTile({
    Key? key,
    required this.index,
    required this.task,
    this.leadingColor, // Optional leading avatar color
    this.onComplete, // Optional completion callback
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
            'Status: ${widget.task.status}',
            style: TextStyle(
              color: Colors.grey[880],
            ),
          ),

          Text(
            'Due Date: ${getFormattedDate(widget.task.dueDate.toDate())}',
            style: TextStyle(
              color: Colors.grey[880],
            ),
          ),

          // Add more details as needed
        ],
      ),
      trailing: widget.task.status != 'Completed'
          ? IconButton(
              icon: const Icon(
                Icons.check,
                color: Colors.green,
                size: 30,
                weight: 40,
              ),
              onPressed: () {
                if (widget.onComplete != null) {
                  widget.onComplete!();
                }
              },
            )
          : null,
      onTap: () {
        // Handle tile tap if needed
      },
    );
  }
}
