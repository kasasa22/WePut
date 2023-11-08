import 'package:flutter/material.dart';

// ignore: must_be_immutable, camel_case_types
class taskTile extends StatefulWidget {
  final String title;
  final String description;
  final String date;

  const taskTile({
    super.key,
    required this.title,
    required this.description,
    required this.date,
  });

  @override
  State<taskTile> createState() => _taskTileState();
}

// ignore: camel_case_types
class _taskTileState extends State<taskTile> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: isChecked,
        onChanged: (bool? value) {
          // Update the state of the checkbox
          setState(() {
            isChecked = value ?? false;
          });
        },
      ),
      title: Text(
        widget.title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        "${widget.description}\n${widget.date}",
        style: const TextStyle(
          fontSize: 10,
        ),
      ),
      trailing: const Icon(Icons.more_horiz),
    );
  }
}
