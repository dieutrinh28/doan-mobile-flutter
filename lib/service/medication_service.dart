import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicine_reminder/model/medication_reminder.dart';

class MedicationService {
  final trackerCollection =
      FirebaseFirestore.instance.collection('medication_reminder');

  // static Stream<List<MedicationReminder>> getAllTracker() {
  //   return trackerCollection.snapshots().map((snapshot) {
  //     return snapshot.docs.map((doc) {
  //       return MedicationReminder.fromJson(doc.data());
  //     }).toList();
  //   });
  // }

  Future<List<MedicationReminder>> getAllTracker() async {
    final snapshot = await trackerCollection.get();
    return snapshot.docs.map((doc) => MedicationReminder.fromJson(doc.data(), doc.id)).toList();
  }
}
