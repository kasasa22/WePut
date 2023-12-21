import 'package:flutter/material.dart';

// ignore: camel_case_types
class teamsCard extends StatelessWidget {
  final String title;
  final String subtitle;
  const teamsCard({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      shape: Border.all(
        color: Colors.lightGreen,
        style: BorderStyle.solid,
        width: 1.0,
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Icon(
              Icons.people_outline_outlined,
              size: 50,
              color: Colors.lightGreen,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              // ignore: unnecessary_brace_in_string_interps
              "${subtitle} members",
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
