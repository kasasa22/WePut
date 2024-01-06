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
        fromFirestore: (snapshots, _) => Task.fromJson(snapshots.data()!),
        toFirestore: (task, _) => task.toJson());
  }

  Stream<QuerySnapshot> getTasks() {
    return _taskRef.snapshots();
  }

  void addTask(Task task) async {
    _taskRef.add(task);
  }

  void updateTask(String taskID, Task task) {
    _taskRef.doc(taskID).update(task.toJson());
  }

  void deleteTask(String taskID) {
    _taskRef.doc(taskID).delete();
  }
}
