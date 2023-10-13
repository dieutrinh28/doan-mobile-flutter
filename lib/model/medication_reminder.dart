import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'medication_reminder.g.dart';

enum TimeReminder { morning, lunch, dinner }

@JsonSerializable(fieldRename: FieldRename.snake)
class MedicationReminder extends Equatable {
  final String medicationId;
  final String medicationName;
  final String? imageUrl;
  final DateTime? dateTime;
  final TimeReminder? timeReminder;
  final String? note;
  final bool? isDone;

  const MedicationReminder({
    required this.medicationId,
    required this.medicationName,
    this.imageUrl,
    this.dateTime,
    this.timeReminder,
    this.note,
    this.isDone,
  });

  MedicationReminder copyWith({
    String? medicationId,
    String? medicationName,
    String? imageUrl,
    DateTime? dateTime,
    TimeReminder? timeReminder,
    String? note,
    bool? isDone,
  }) {
    return MedicationReminder(
      medicationId: medicationId ?? this.medicationId,
      medicationName: medicationName ?? this.medicationName,
      imageUrl: imageUrl ?? this.imageUrl,
      dateTime: dateTime ?? this.dateTime,
      timeReminder: timeReminder ?? this.timeReminder,
      note: note ?? this.note,
      isDone: isDone ?? this.isDone,
    );
  }

  // factory MedicationReminder.fromJson(Map<String, dynamic> json) =>
  //     _$MedicationReminderFromJson(json);

  factory MedicationReminder.fromJson(
     Map<String, dynamic> json,
      String id,
      ) {
    return MedicationReminder(
      medicationId: id,
      medicationName: json['medication_name'],
      imageUrl: json['image_url'],
      dateTime: json['date_time'].toDate(),
      timeReminder: json['time_reminder'],
      note: json['note'],
      isDone: json['is_done'],
    );
  }

  Map<String, dynamic> toJson() => _$MedicationReminderToJson(this);

  @override
  List<Object?> get props => [
        medicationId,
        medicationName,
        imageUrl,
        dateTime,
        timeReminder,
        note,
        isDone,
      ];
}
