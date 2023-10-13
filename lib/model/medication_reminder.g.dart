// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medication_reminder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicationReminder _$MedicationReminderFromJson(Map<String, dynamic> json) =>
    MedicationReminder(
      medicationId: json['medication_id'] as String,
      medicationName: json['medication_name'] as String,
      imageUrl: json['image_url'] as String?,
      dateTime: json['date_time'] == null
          ? null
          : DateTime.parse(json['date_time'] as String),
      timeReminder:
          $enumDecodeNullable(_$TimeReminderEnumMap, json['time_reminder']),
      note: json['note'] as String?,
      isDone: json['is_done'] as bool?,
    );

Map<String, dynamic> _$MedicationReminderToJson(MedicationReminder instance) =>
    <String, dynamic>{
      'medication_id': instance.medicationId,
      'medication_name': instance.medicationName,
      'image_url': instance.imageUrl,
      'date_time': instance.dateTime?.toIso8601String(),
      'time_reminder': _$TimeReminderEnumMap[instance.timeReminder],
      'note': instance.note,
      'is_done': instance.isDone,
    };

const _$TimeReminderEnumMap = {
  TimeReminder.morning: 'morning',
  TimeReminder.lunch: 'lunch',
  TimeReminder.dinner: 'dinner',
};
