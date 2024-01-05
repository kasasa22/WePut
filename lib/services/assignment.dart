import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/assignment.dart';

class AssignmentService {
  final CollectionReference assignmentsCollection =
      FirebaseFirestore.instance.collection('assignments');

  Future<void> addAssignment(Assignment assignment) async {
    await assignmentsCollection.add(assignment.toJson());
  }

  Future<void> updateAssignment(Assignment assignment) async {
    await assignmentsCollection
        .doc(assignment.assignmentId)
        .update(assignment.toJson());
  }

  Future<void> deleteAssignment(String assignmentId) async {
    await assignmentsCollection.doc(assignmentId).delete();
  }

  Stream<List<Assignment>> getAssignmentsStream() {
    return assignmentsCollection.snapshots().map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => Assignment.fromFirestore(doc),
              )
              .toList(),
        );
  }
}
