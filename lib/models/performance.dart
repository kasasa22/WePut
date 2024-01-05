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

  factory PerformanceMetrics.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return PerformanceMetrics(
      userId: doc.id,
      completedTasks: data['completedTasks'] ?? 0,
      averageCompletionTime: (data['averageCompletionTime'] ?? 0).toDouble(),
      totalEvaluationPoints: data['totalEvaluationPoints'] ?? 0,
    );
  }

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
      userId: this.userId,
      completedTasks: completedTasks ?? this.completedTasks,
      averageCompletionTime:
          averageCompletionTime ?? this.averageCompletionTime,
      totalEvaluationPoints:
          totalEvaluationPoints ?? this.totalEvaluationPoints,
    );
  }
}
