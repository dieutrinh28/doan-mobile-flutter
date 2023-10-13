part of 'tracker_bloc.dart';

enum TrackerStatus { init, loading, success, error }

class TrackerState extends Equatable {
  final TrackerStatus status;
  final List<MedicationReminder>? list;
  final String? error;

  const TrackerState({required this.status, this.list, this.error});

  TrackerState copyWith({
    TrackerStatus? status,
    List<MedicationReminder>? list,
    String? error,
  }) {
    return TrackerState(
      status: status ?? this.status,
      list: list ?? this.list,
      error: error ?? this.error,
    );
  }

  factory TrackerState.initial() {
    return const TrackerState(
      status: TrackerStatus.init,
      list: [],
      error: null,
    );
  }

  @override
  List<Object?> get props => [status, list, error];
}
