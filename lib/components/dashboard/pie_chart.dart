import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartWidget extends StatelessWidget {
  const PieChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3, // Aspect ratio of the pie chart
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(
              value: 30, // Example value for the section
              color: Colors.blue[600], // Color of the section
              title: '30%', // Title of the section (optional)
              radius: 30, // Radius of the section (optional)
              titleStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white), // Style for the title (optional)
            ),
            // Add more PieChartSectionData for additional sections
          ],
          borderData: FlBorderData(show: false), // Hide border (optional)
          sectionsSpace: 0, // Space between sections (optional)
          centerSpaceRadius: 40, // Radius of the center space (optional)
        ),
      ),
    );
  }
}
