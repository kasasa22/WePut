import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class UserService {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> addUser(User user) async {
    await usersCollection.doc(user.userId).set(user.toJson());
  }

  Future<void> updateUser(User user) async {
    await usersCollection.doc(user.userId).update(user.toJson());
  }

  Stream<List<User>> getUsersStream() {
    return usersCollection.snapshots().map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => User.fromFirestore(doc),
              )
              .toList(),
        );
  }
}
