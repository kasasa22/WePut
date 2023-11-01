import 'package:flutter/material.dart ';

class TeamCard extends StatelessWidget {
  final String teamName;
  final String ImageUrl;
  final int membersNumber;

  const TeamCard({
    super.key,
    required this.teamName,
    // ignore: non_constant_identifier_names
    required this.ImageUrl,
    required this.membersNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
