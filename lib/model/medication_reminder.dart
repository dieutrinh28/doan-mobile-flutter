import 'package:equatable/equatable.dart';
import 'package:googleapis/cloudsearch/v1.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:medicine_reminder/config/util.dart';

enum TimeReminder { morning, lunch, dinner }

@JsonSerializable(fieldRename: FieldRename.snake)
class MedicationReminder extends Equatable {
  final String medicationId;
  final String medicationName;
  final String? imageUrl;
  final DateTime? startTime;
  final DateTime? endTime;
  final String? note;
  final bool? isDone;

  const MedicationReminder({
    required this.medicationId,
    required this.medicationName,
    this.imageUrl,
    this.startTime,
    this.endTime,
    this.note,
    this.isDone,
  });

  MedicationReminder copyWith({
    String? medicationId,
    String? medicationName,
    String? imageUrl,
    DateTime? startTime,
    DateTime? endTime,
    String? note,
    bool? isDone,
  }) {
    return MedicationReminder(
      medicationId: medicationId ?? this.medicationId,
      medicationName: medicationName ?? this.medicationName,
      imageUrl: imageUrl ?? this.imageUrl,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      note: note ?? this.note,
      isDone: isDone ?? this.isDone,
    );
  }

  factory MedicationReminder.fromJson(
    Map<String, dynamic> json,
    String id,
  ) {
    return MedicationReminder(
      medicationId: id,
      medicationName: json['medication_name'],
      imageUrl: json['image_url'],
      startTime: json['start_time']?.toDate(),
      endTime: json['end_time']?.toDate(),
      note: json['note'],
      isDone: json['is_done'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'medication_id': medicationId,
      'medication_name': medicationName,
      'image_url': imageUrl,
      'start_time':
          MedicineUtil.convertDateTimeToTimestamp(startTime ?? DateTime.now()),
      'end_time':
          MedicineUtil.convertDateTimeToTimestamp(endTime ?? DateTime.now()),
      'note': note,
      'is_done': isDone,
    };
  }

  @override
  List<Object?> get props => [
        medicationId,
        medicationName,
        imageUrl,
        startTime,
        endTime,
        note,
        isDone,
      ];
}
