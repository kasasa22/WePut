import 'package:cloud_firestore/cloud_firestore.dart';

class Notification {
  String notificationId;
  String userId;
  String message;
  Timestamp timestamp;
  bool viewed;

  Notification({
    required this.notificationId,
    required this.userId,
    required this.message,
    required this.timestamp,
    required this.viewed,
  });

  Notification.fromJson(Map<String, Object?> json)
      : this(
          notificationId: json['notificationId'] as String? ?? '',
          userId: json['userId'] as String? ?? '',
          message: json['message'] as String? ?? '',
          timestamp: json['timestamp'] == null
              ? Timestamp.now()
              : (json['endTime'] as Timestamp),
          viewed: json['viewed'] as bool? ?? false,
        );

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'message': message,
      'timestamp': timestamp,
      'viewed': viewed,
    };
  }

  Notification copyWith({
    String? userId,
    String? message,
    Timestamp? timestamp,
    bool? viewed,
  }) {
    return Notification(
      notificationId: notificationId,
      userId: userId ?? this.userId,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
      viewed: viewed ?? this.viewed,
    );
  }
}
