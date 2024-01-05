import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task.dart';

// ignore: constant_identifier_names
const String COLLECTION_REF = "tasks";

class TaskService {
  final _firestore = FirebaseFirestore.instance;

  // ignore: unused_field
  late final CollectionReference _taskRef;

  TaskService() {
    _taskRef = _firestore.collection(COLLECTION_REF).withConverter<Task>(
        fromFirestore: (snapshots, _) =>
            Task.fromFirestore(snapshots.data()! as DocumentSnapshot<Object?>),
        toFirestore: (task, _) => task.toJson());
  }

  Stream<QuerySnapshot> getTasks() {
    return _taskRef.snapshots();
  }

  // Future<void> addTask(Task task) async {
  //   await tasksCollection.add(task.toJson());
  // }

  // Future<void> updateTask(Task task) async {
  //   await tasksCollection.doc(task.taskId).update(task.toJson());
  // }

  // Future<void> deleteTask(String taskId) async {
  //   await tasksCollection.doc(taskId).delete();
  // }

  // Stream<List<Task>> getTasksStream() {
  //   return tasksCollection.snapshots().map(
  //         (snapshot) => snapshot.docs
  //             .map(
  //               (doc) => Task.fromFirestore(doc),
  //             )
  //             .toList(),
  //       );
  // }
}
