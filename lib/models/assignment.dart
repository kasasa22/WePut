import 'package:cloud_firestore/cloud_firestore.dart';

class Assignment {
  String assignmentId;
  String teamName;
  String userId;
  String taskId;
  Timestamp assignmentTime;
  String completionStatus;

  Assignment({
    required this.teamName,
    required this.assignmentId,
    required this.userId,
    required this.taskId,
    required this.assignmentTime,
    required this.completionStatus,
  });

  Assignment.fromJson(Map<String, Object?> json)
      : this(
          teamName: json['teamName'] as String? ?? '',
          assignmentId: json['assignmentId'] as String? ?? '',
          userId: json['userId'] as String? ?? '',
          taskId: json['taskId'] as String? ?? '',
          assignmentTime: json['assignmentTime'] == null
              ? Timestamp.now()
              : (json['endTime'] as Timestamp),
          completionStatus: json['completionStatus'] as String? ?? '',
        );

  Map<String, dynamic> toJson() {
    return {
      'teamName': teamName,
      'userId': userId,
      'taskId': taskId,
      'assignmentTime': assignmentTime,
      'completionStatus': completionStatus,
    };
  }

  Assignment copyWith({
    String? teamName,
    String? userId,
    String? taskId,
    Timestamp? assignmentTime,
    String? completionStatus,
  }) {
    return Assignment(
      teamName: teamName ?? this.teamName,
      assignmentId: assignmentId,
      userId: userId ?? this.userId,
      taskId: taskId ?? this.taskId,
      assignmentTime: assignmentTime ?? this.assignmentTime,
      completionStatus: completionStatus ?? this.completionStatus,
    );
  }
}
