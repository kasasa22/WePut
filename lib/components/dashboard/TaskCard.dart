// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomCard extends StatelessWidget {
  final IconData icon;
  final Color cardColor;
  final String title;
  final double cardHeight;
  final double cardWidth;
  final String taskDate;
  final bool isCompleted;

  CustomCard({
    Key? key,
    required this.icon,
    required this.cardColor,
    required this.title,
    this.cardHeight = 50.0,
    this.cardWidth = 300.0, // Adjusted for a horizontal layout
    required this.taskDate,
    this.isCompleted = false,
  }) : super(key: key);

  final DateFormat _dateFormat = DateFormat('dd MMMM yyyy HH:mm');

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      color: cardColor,
      child: SizedBox(
        height: cardHeight,
        width: cardWidth,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    size: 20,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        _dateFormat.format(DateTime.parse(
                            taskDate)), // Convert String to DateTime
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isCompleted ? Colors.green : Colors.red,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  isCompleted ? 'Completed' : 'Pending',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Example usage:
// CustomCard(
//   icon: Icons.star,
//   cardColor: Colors.blue,
//   title: 'Star Card',
//   taskDate: '2024-01-08',
//   isCompleted: true,
//   cardHeight: 150.0,
//   cardWidth: 300.0,
// )
