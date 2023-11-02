part of 'tracker_bloc.dart';

@immutable
abstract class TrackerEvent extends Equatable {}

class GetAllTrackerEvent extends TrackerEvent {
  @override
  List<Object?> get props => [];
}

class GetTrackerByDateTimeEvent extends TrackerEvent {
  late DateTime dateTime;

  GetTrackerByDateTimeEvent(this.dateTime);

  @override
  List<Object?> get props => [dateTime];
}

class ToggleCheckTrackerEvent extends TrackerEvent {
  late MedicationReminder medicationReminder;

  ToggleCheckTrackerEvent(this.medicationReminder);

  @override
  List<Object?> get props => [medicationReminder];
}

class CreateMedicationEvent extends TrackerEvent {
  final String medicationName;
  final DateTime startDate;
  final DateTime endDate;
  final MedicineType medicineType;
  final DoseType doseType;
  final int doseAmount;
  final String note;

  CreateMedicationEvent({
    required this.medicationName,
    required this.startDate,
    required this.endDate,
    required this.medicineType,
    required this.doseType,
    required this.doseAmount,
    required this.note,
  });

  @override
  List<Object?> get props => [
        medicationName,
        startDate,
        endDate,
        medicineType,
        doseType,
        doseAmount,
        note,
      ];
}


