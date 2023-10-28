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
  final DateTime start;
  final DateTime end;

  CreateMedicationEvent({
    required this.medicationName,
    required this.start,
    required this.end,
  });

  @override
  List<Object?> get props => [
        medicationName,
        start,
        end,
      ];
}
