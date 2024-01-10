class User {
  String userId;
  String name;
  String email;
  String role;
  int completedTasks;
  int averageCompletionTime;

  User({
    required this.userId,
    required this.name,
    required this.email,
    required this.role,
    required this.completedTasks,
    required this.averageCompletionTime,
  });

  User.fromJson(Map<String, Object?> json)
      : this(
          userId: json['userId'] as String? ?? '',
          name: json['name'] as String? ?? '',
          email: json['email'] as String? ?? '',
          role: json['role'] as String? ?? '',
          completedTasks: json['completedTasks'] as int? ?? 0,
          averageCompletionTime: json['averageCompletionTime'] as int? ?? 0,
        );

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
    int? averageCompletionTime,
  }) {
    return User(
      userId: userId,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      completedTasks: completedTasks ?? this.completedTasks,
      averageCompletionTime:
          averageCompletionTime ?? this.averageCompletionTime,
    );
  }
}
