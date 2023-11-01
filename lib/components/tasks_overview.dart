import 'package:flutter/material.dart';

class TasksOverview extends StatelessWidget {
  final IconData icon;
  final String text;

  const TasksOverview({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 214, 213, 213)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(children: [
        Icon(
          icon,
          size: 40,
          color: const Color.fromARGB(255, 188, 126, 10),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          text,
          style: const TextStyle(fontSize: 16),
        )
      ]),
    );
  }
}
