import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/performance.dart';

class PerformanceMetricsService {
  final CollectionReference metricsCollection =
      FirebaseFirestore.instance.collection('performanceMetrics');

  Future<void> addMetrics(PerformanceMetrics metrics) async {
    await metricsCollection.doc(metrics.userId).set(metrics.toJson());
  }

  Future<void> updateMetrics(PerformanceMetrics metrics) async {
    await metricsCollection.doc(metrics.userId).update(metrics.toJson());
  }

  Stream<List<PerformanceMetrics>> getMetricsStream() {
    return metricsCollection.snapshots().map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => PerformanceMetrics.fromFirestore(doc),
              )
              .toList(),
        );
  }
}
