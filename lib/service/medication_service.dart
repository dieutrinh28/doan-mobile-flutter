import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicine_reminder/config/common_enum.dart';
import 'package:medicine_reminder/model/medication_reminder.dart';

class MedicationService {
  final trackerCollection =
      FirebaseFirestore.instance.collection('medication_reminder');

  Future<List<MedicationReminder>> getAllTracker() async {
    final snapshot = await trackerCollection.get();
    return snapshot.docs
        .map((doc) => MedicationReminder.fromJson(doc.data(), doc.id))
        .toList();
  }

  Future<List<MedicationReminder>> getTrackerByDateTime(
      DateTime dateTime) async {
    final snapshot = await trackerCollection
        .where('start_time', isGreaterThanOrEqualTo: dateTime)
        .where('start_time', isLessThan: dateTime.add(const Duration(days: 1)))
        .get();
    return snapshot.docs
        .map((doc) => MedicationReminder.fromJson(doc.data(), doc.id))
        .toList();
  }

  Future<void> createTracker({
    required String medicationName,
    required DateTime startTime,
    required DateTime endTime,
    required MedicineType medicineType,
    required DoseType doseType,
    required int doseAmount,
    required String note,
  }) {
    return trackerCollection.add({
      'medication_name': medicationName,
      'image_url': 'https://i.pinimg.com/564x/fe/0a/a9/fe0aa9358bfa75709709818fa4d55010.jpg',
      'start_time': startTime,
      'end_time': endTime,
      'medicine_type': MedicineTypeExtension.toInt(medicineType),
      'dose_type': DoseTypeExtension.toInt(doseType),
      'dose_amount': doseAmount,
      'note': note,
      'is_done': false,
    });
  }
}
