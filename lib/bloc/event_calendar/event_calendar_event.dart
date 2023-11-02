part of 'event_calendar_bloc.dart';

abstract class EventCalendarEvent extends Equatable {
  const EventCalendarEvent();
}

class GetAllEventCalendarEvent extends EventCalendarEvent {
  final String accessToken;
  GetAllEventCalendarEvent({
    required this.accessToken,
  });
  @override
  List<Object?> get props => [
        accessToken,
      ];
}

class GetEventCalendarByDateTimeEvent extends EventCalendarEvent {
  final DateTime dateTime;
  final String accessToken;
  GetEventCalendarByDateTimeEvent({
    required this.dateTime,
    required this.accessToken,
  });
  @override
  List<Object?> get props => [
        dateTime,
        accessToken,
      ];
}

class CreateEventCalendarEvent extends EventCalendarEvent {
  final String medicationName;
  final DateTime startDate;
  final TimeOfDay startTime;
  final DateTime endDate;
  final TimeOfDay endTime;
  final String accessToken;

  CreateEventCalendarEvent({
    required this.medicationName,
    required this.startDate,
    required this.startTime,
    required this.endDate,
    required this.endTime,
    required this.accessToken,
  });

  @override
  List<Object?> get props => [
        medicationName,
        startDate,
        startTime,
        endDate,
        endTime,
        accessToken,
      ];
}
