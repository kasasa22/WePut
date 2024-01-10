import 'package:cloud_firestore/cloud_firestore.dart';

class Assignment {
  String teamName;
  String userId;
  String taskId;
  Timestamp assignmentTime;
  String completionStatus;

  Assignment({
    required this.teamName,
    required this.userId,
    required this.taskId,
    required this.assignmentTime,
    required this.completionStatus,
  });

  Assignment.fromJson(Map<String, dynamic> json)
      : this(
          teamName: json['teamName'] as String? ?? '',
          userId: json['userId'] as String? ?? '',
          taskId: json['taskId'] as String? ?? '',
          assignmentTime: json['assignmentTime'] == null
              ? Timestamp.now()
              : (json['assignmentTime'] as Timestamp),
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
      userId: userId ?? this.userId,
      taskId: taskId ?? this.taskId,
      assignmentTime: assignmentTime ?? this.assignmentTime,
      completionStatus: completionStatus ?? this.completionStatus,
    );
  }
}
