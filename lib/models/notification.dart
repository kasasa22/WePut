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

  factory Notification.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Notification(
      notificationId: doc.id,
      userId: data['userId'] ?? '',
      message: data['message'] ?? '',
      timestamp: data['timestamp'] ?? Timestamp.now(),
      viewed: data['viewed'] ?? false,
    );
  }

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
      notificationId: this.notificationId,
      userId: userId ?? this.userId,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
      viewed: viewed ?? this.viewed,
    );
  }
}
