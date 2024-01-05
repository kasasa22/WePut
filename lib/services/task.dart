import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task.dart';

class TaskService {
  final CollectionReference tasksCollection =
      FirebaseFirestore.instance.collection('tasks');

  Future<void> addTask(Task task) async {
    await tasksCollection.add(task.toJson());
  }

  Future<void> updateTask(Task task) async {
    await tasksCollection.doc(task.taskId).update(task.toJson());
  }

  Future<void> deleteTask(String taskId) async {
    await tasksCollection.doc(taskId).delete();
  }

  Stream<List<Task>> getTasksStream() {
    return tasksCollection.snapshots().map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => Task.fromFirestore(doc),
              )
              .toList(),
        );
  }
}
