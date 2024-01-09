import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartWidget extends StatelessWidget {
  const LineChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300, // Set the height of the chart
      padding: const EdgeInsets.all(16),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false), // Hide grid lines (optional)
          titlesData: FlTitlesData(show: false), // Hide titles (optional)
          borderData: FlBorderData(
              show: true), // Show borders around the chart (optional)
          lineBarsData: [
            LineChartBarData(
              spots: [
                const FlSpot(0, 3), // Example data point
                const FlSpot(1, 1.5), // Example data point
                const FlSpot(2, 4), // Example data point
                const FlSpot(3, 2), // Example data point
              ],
              isCurved: true, // Make the line curve (optional)

              barWidth: 4, // Width of the line (optional)
              belowBarData:
                  BarAreaData(show: false), // Hide below line area (optional)
            ),
          ],
        ),
      ),
    );
  }
}
