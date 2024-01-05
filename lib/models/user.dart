import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String userId;
  String name;
  String email;
  String role;
  int completedTasks;
  double averageCompletionTime;

  User({
    required this.userId,
    required this.name,
    required this.email,
    required this.role,
    required this.completedTasks,
    required this.averageCompletionTime,
  });

  factory User.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return User(
      userId: doc.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      role: data['role'] ?? '',
      completedTasks: data['completedTasks'] ?? 0,
      averageCompletionTime: (data['averageCompletionTime'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'role': role,
      'completedTasks': completedTasks,
      'averageCompletionTime': averageCompletionTime,
    };
  }

  User copyWith({
    String? name,
    String? email,
    String? role,
    int? completedTasks,
    double? averageCompletionTime,
  }) {
    return User(
      userId: this.userId,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      completedTasks: completedTasks ?? this.completedTasks,
      averageCompletionTime:
          averageCompletionTime ?? this.averageCompletionTime,
    );
  }
}
