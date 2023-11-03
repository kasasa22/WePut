import 'package:flutter/material.dart ';

class TeamCard extends StatelessWidget {
  final String teamName;
  final IconData icon;
  final int membersNumber;

  const TeamCard({
    super.key,
    required this.teamName,
    // ignore: non_constant_identifier_names
    required this.icon,
    required this.membersNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
