import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicine_reminder/model/medication_reminder.dart';

class MedicationService {
  final trackerCollection =
      FirebaseFirestore.instance.collection('medication_reminder');

  Future<List<MedicationReminder>> getAllTracker() async {
    final snapshot = await trackerCollection.get();
    return snapshot.docs.map((doc) => MedicationReminder.fromJson(doc.data(), doc.id)).toList();
  }

  Future<List<MedicationReminder>> getTrackerByDateTime(DateTime dateTime) async {
    final snapshot = await trackerCollection
        .where('start_time', isGreaterThanOrEqualTo: dateTime)
        .where('start_time', isLessThan: dateTime.add(const Duration(days: 1)))
        .get();
    return snapshot.docs.map((doc) => MedicationReminder.fromJson(doc.data(), doc.id)).toList();
  }

  Future<void> createTracker() async {

  }

}
