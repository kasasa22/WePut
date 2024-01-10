import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/notification.dart';

// ignore: constant_identifier_names
const String COLLECTION_REF = "notifications";

class NotificationService {
  final _firestore = FirebaseFirestore.instance;

  // ignore: unused_field
  late final CollectionReference _notificationRef;

  NotificationService() {
    _notificationRef = _firestore
        .collection(COLLECTION_REF)
        .withConverter<Message>(
            fromFirestore: (snapshots, _) =>
                Message.fromJson(snapshots.data()!),
            toFirestore: (notification, _) => notification.toJson());
  }

  Stream<QuerySnapshot> getnotifications() {
    return _notificationRef.snapshots();
  }

  void addNotification(Message notification) async {
    _notificationRef.add(notification);
  }

  void updateNotification(String notificationID, Message notification) {
    _notificationRef.doc(notificationID).update(notification.toJson());
  }

  void deleteNotification(String notificationID) {
    _notificationRef.doc(notificationID).delete();
  }
}
