// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final IconData icon;
  final Color cardColor;
  final String title;
  final double cardHeight;
  final double cardWidth;

  const CustomCard({
    Key? key,
    required this.icon,
    required this.cardColor,
    required this.title,
    this.cardHeight = 150.0, // Set the desired height
    this.cardWidth = 120.0, // Set the desired width
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3, // Adjust the elevation as needed
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      color: cardColor,
      child: Container(
        height: cardHeight,
        width: cardWidth,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40, // Adjust the icon size as needed
                color: Colors.white, // You can customize the icon color
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // You can customize the text color
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
//   cardHeight: 150.0,
//   cardWidth: 120.0,
// )
