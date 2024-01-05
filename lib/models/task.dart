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

  factory Task.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Task(
      taskId: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      dueDate: data['dueDate'] ?? Timestamp.now(),
      status: data['status'] ?? '',
      assignedUserId: data['assignedUserId'] ?? '',
      priority: data['priority'] ?? '',
      category: data['category'] ?? '',
      progress: data['progress'] ?? 0,
      comments: List<String>.from(data['comments'] ?? []),
      startTime: data['startTime'] ?? Timestamp.now(),
      endTime: data['endTime'] ?? Timestamp.now(),
      evaluation: (data['evaluation'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
  }

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
