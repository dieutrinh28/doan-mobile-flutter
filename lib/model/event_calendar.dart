import 'package:equatable/equatable.dart';

class EventCalendar extends Equatable {
  final String medicationId;
  final String medicationName;
  final DateTime? dateTime;
  final String? note;

  const EventCalendar({
    required this.medicationId,
    required this.medicationName,
    this.dateTime,
    this.note,
  });

  EventCalendar copyWith({
    String? medicationId,
    String? medicationName,
    DateTime? dateTime,
    String? note,
  }) {
    return EventCalendar(
      medicationId: medicationId ?? this.medicationId,
      medicationName: medicationName ?? this.medicationName,
      dateTime: dateTime ?? this.dateTime,
      note: note ?? this.note,
    );
  }

  factory EventCalendar.fromJson(
      Map<String, dynamic> json,
      ) {
    return EventCalendar(
      medicationId: json['id'],
      medicationName: json['summary'],
      dateTime: json['start'],
      note: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'medication_id': medicationId,
      'status': medicationName,
      'start': dateTime,
      'note': note,
    };
  }

  @override
  List<Object?> get props => [
    medicationId,
    medicationName,
    dateTime,
    note,
  ];
}
