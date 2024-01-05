import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String taskId;
  String title;
  String description;
  Timestamp dueDate;
  String status;
  String assignedUserId;
  String priority;
  String category;
  int progress;
  List<String> comments;
  Timestamp startTime;
  Timestamp endTime;
  double evaluation;

  Task({
    required this.taskId,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.status,
    required this.assignedUserId,
    required this.priority,
    required this.category,
    required this.progress,
    required this.comments,
    required this.startTime,
    required this.endTime,
    required this.evaluation,
  });

  Task.fromJson(Map<String, Object?> json)
      : this(
          taskId: json['taskId']! as String,
          title: json['title']! as String,
          description: json['description']! as String,
          dueDate: json['dueDate']! as Timestamp,
          status: json['status']! as String,
          assignedUserId: json['assignedUserId']! as String,
          priority: json['priority']! as String,
          category: json['category']! as String,
          progress: json['progress']! as int,
          comments: json['comments']! as List<String>,
          startTime: json['startTime']! as Timestamp,
          endTime: json['endTime']! as Timestamp,
          evaluation: json['evaluation']! as double,
        );

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'dueDate': dueDate,
        'status': status,
        'assignedUserId': assignedUserId,
        'priority': priority,
        'category': category,
        'progress': progress,
        'comments': comments,
        'startTime': startTime,
        'endTime': endTime,
        'evaluation': evaluation,
      };

  Task copyWith({
    String? title,
    String? description,
    Timestamp? dueDate,
    String? status,
    String? assignedUserId,
    String? priority,
    String? category,
    int? progress,
    List<String>? comments,
    Timestamp? startTime,
    Timestamp? endTime,
    double? evaluation,
  }) {
    return Task(
      taskId: taskId,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      status: status ?? this.status,
      assignedUserId: assignedUserId ?? this.assignedUserId,
      priority: priority ?? this.priority,
      category: category ?? this.category,
      progress: progress ?? this.progress,
      comments: comments ?? this.comments,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      evaluation: evaluation ?? this.evaluation,
    );
  }
}
