// ignore_for_file: non_constant_identifier_names
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/performance.dart';

// ignore: constant_identifier_names
const String COLLECTION_REF = "performanceMetrics";

class PerformanceMetricsService {
  final _firestore = FirebaseFirestore.instance;

  // ignore: unused_field
  late final CollectionReference _performance_metricsRef;

  PerformanceService() {
    _performance_metricsRef = _firestore
        .collection(COLLECTION_REF)
        .withConverter<PerformanceMetrics>(
            fromFirestore: (snapshots, _) =>
                PerformanceMetrics.fromJson(snapshots.data()!),
            toFirestore: (performanceMetrics, _) =>
                performanceMetrics.toJson());
  }

  Stream<QuerySnapshot> getTasks() {
    return _performance_metricsRef.snapshots();
  }

  void addPerformanceMetrics(PerformanceMetrics performance_metrics) async {
    _performance_metricsRef.add(performance_metrics);
  }

  void updatePerformanceMetrics(
      String performance_metricsID, PerformanceMetrics performance_metrics) {
    _performance_metricsRef
        .doc(performance_metricsID)
        .update(performance_metrics.toJson());
  }

  void deletePerformanceMetrics(String performance_metricsID) {
    _performance_metricsRef.doc(performance_metricsID).delete();
  }
}
