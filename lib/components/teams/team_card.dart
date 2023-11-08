import 'package:flutter/material.dart';

class TeamCard extends StatelessWidget {
  final String teamName;
  final IconData icon;
  final int membersNumber;

  const TeamCard({
    Key? key,
    required this.teamName,
    required this.icon,
    required this.membersNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5, // Set the elevation for a shadow effect
      margin: const EdgeInsets.all(10), // Set margin around the card
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Padding inside the card
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              size: 50,
              color: Colors.blue, // Icon color
            ),
            const SizedBox(height: 10), // Spacer between icon and text
            Text(
              teamName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
                height: 5), // Spacer between teamName and membersNumber
            Text(
              'Members: $membersNumber',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
