import 'package:cloud_firestore/cloud_firestore.dart';

class PerformanceMetrics {
  String userId;
  int completedTasks;
  double averageCompletionTime;
  int totalEvaluationPoints;

  PerformanceMetrics({
    required this.userId,
    required this.completedTasks,
    required this.averageCompletionTime,
    required this.totalEvaluationPoints,
  });

  PerformanceMetrics.fromJson(Map<String, Object?> json)
      : this(
          userId: json['notificationId'] as String? ?? '',
          completedTasks: json['notificationId'] as int? ?? 0,
          averageCompletionTime:
              (data['averageCompletionTime'] ?? 0).toDouble(),
          totalEvaluationPoints: json['notificationId'] as int? ?? 0,
        );

  Map<String, dynamic> toJson() {
    return {
      'completedTasks': completedTasks,
      'averageCompletionTime': averageCompletionTime,
      'totalEvaluationPoints': totalEvaluationPoints,
    };
  }

  PerformanceMetrics copyWith({
    int? completedTasks,
    double? averageCompletionTime,
    int? totalEvaluationPoints,
  }) {
    return PerformanceMetrics(
      userId: userId,
      completedTasks: completedTasks ?? this.completedTasks,
      averageCompletionTime:
          averageCompletionTime ?? this.averageCompletionTime,
      totalEvaluationPoints:
          totalEvaluationPoints ?? this.totalEvaluationPoints,
    );
  }
}
