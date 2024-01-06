import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/assignment.dart';

// ignore: constant_identifier_names
const String COLLECTION_REF = "assignments";

class AssignmentService {
  final _firestore = FirebaseFirestore.instance;

  // ignore: unused_field
  late final CollectionReference _assignmentRef;

  AssignmentService() {
    _assignmentRef = _firestore
        .collection(COLLECTION_REF)
        .withConverter<Assignment>(
            fromFirestore: (snapshots, _) =>
                Assignment.fromJson(snapshots.data()!),
            toFirestore: (assignment, _) => assignment.toJson());
  }

  Stream<QuerySnapshot> getAssignments() {
    return _assignmentRef.snapshots();
  }

  void addAssignment(Assignment assignment) async {
    _assignmentRef.add(assignment);
  }

  void updateAssignment(String assignmentID, Assignment assignment) {
    _assignmentRef.doc(assignmentID).update(assignment.toJson());
  }

  void deleteAssignment(String assignmentID) {
    _assignmentRef.doc(assignmentID).delete();
  }
}
