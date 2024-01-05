import 'package:cloud_firestore/cloud_firestore.dart';

class Assignment {
  String assignmentId;
  String userId;
  String taskId;
  Timestamp assignmentTime;
  String completionStatus;

  Assignment({
    required this.assignmentId,
    required this.userId,
    required this.taskId,
    required this.assignmentTime,
    required this.completionStatus,
  });

  factory Assignment.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Assignment(
      assignmentId: doc.id,
      userId: data['userId'] ?? '',
      taskId: data['taskId'] ?? '',
      assignmentTime: data['assignmentTime'] ?? Timestamp.now(),
      completionStatus: data['completionStatus'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'taskId': taskId,
      'assignmentTime': assignmentTime,
      'completionStatus': completionStatus,
    };
  }

  Assignment copyWith({
    String? userId,
    String? taskId,
    Timestamp? assignmentTime,
    String? completionStatus,
  }) {
    return Assignment(
      assignmentId: assignmentId,
      userId: userId ?? this.userId,
      taskId: taskId ?? this.taskId,
      assignmentTime: assignmentTime ?? this.assignmentTime,
      completionStatus: completionStatus ?? this.completionStatus,
    );
  }
}
