import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';

// ignore: constant_identifier_names
const String COLLECTION_REF = "users";

class UserService {
  final _firestore = FirebaseFirestore.instance;

  // ignore: unused_field
  late final CollectionReference _userRef;

  UserService() {
    _userRef = _firestore.collection(COLLECTION_REF).withConverter<User>(
        fromFirestore: (snapshots, _) => User.fromJson(snapshots.data()!),
        toFirestore: (user, _) => user.toJson());
  }

  Stream<QuerySnapshot> getUsers() {
    return _userRef.snapshots();
  }

  Future<String?> getUserNameByEmail(String email) async {
    DocumentSnapshot<Object?> snapshot = await _userRef.doc(email).get();
    return (snapshot.data() as User?)?.name;
  }

  void addUser(User user) async {
    _userRef.add(user);
  }

  void updateUser(String userID, User user) {
    _userRef.doc(userID).update(user.toJson());
  }

  void deleteUser(String userID) {
    _userRef.doc(userID).delete();
  }
}
