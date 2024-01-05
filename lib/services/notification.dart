import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/notification.dart';

class NotificationService {
  final CollectionReference notificationsCollection =
      FirebaseFirestore.instance.collection('notifications');

  Future<void> addNotification(Notification notification) async {
    await notificationsCollection.add(notification.toJson());
  }

  Future<void> updateNotification(Notification notification) async {
    await notificationsCollection
        .doc(notification.notificationId)
        .update(notification.toJson());
  }

  Stream<List<Notification>> getNotificationsStream() {
    return notificationsCollection.snapshots().map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => Notification.fromFirestore(doc),
              )
              .toList(),
        );
  }
}
