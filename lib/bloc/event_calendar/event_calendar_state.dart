part of 'event_calendar_bloc.dart';

enum EventCalendarStatus {
  init,
  loading,
  success,
  error,
}

class EventCalendarState extends Equatable {
  final EventCalendarStatus status;
  final List<EventCalendar>? list;
  final String? error;

  const EventCalendarState({
    required this.status,
    required this.list,
    required this.error,
  });

  factory EventCalendarState.initial() {
    return const EventCalendarState(
      status: EventCalendarStatus.init,
      list: [],
      error: null,
    );
  }

  EventCalendarState copyWith({
    EventCalendarStatus? status,
    List<EventCalendar>? list,
    String? error,
  }) {
    return EventCalendarState(
      status: status ?? this.status,
      list: list ?? this.list,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, list, error];
}



