part of 'tracker_bloc.dart';

@immutable
abstract class TrackerEvent extends Equatable {}

class GetAllTrackerEvent extends TrackerEvent {
  @override
  List<Object?> get props => [];

}

class ToggleCheckTrackerEvent extends TrackerEvent {
  late MedicationReminder medicationReminder;

  ToggleCheckTrackerEvent(this.medicationReminder);

  @override
  List<Object?> get props => [medicationReminder];

}
