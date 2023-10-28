import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:medicine_reminder/config/common_enum.dart';
import 'package:medicine_reminder/config/util.dart';

enum TimeReminder { morning, lunch, dinner }

@JsonSerializable(fieldRename: FieldRename.snake)
class MedicationReminder extends Equatable {
  final String medicationId;
  final String medicationName;
  final String? imageUrl;
  final DateTime? startTime;
  final DateTime? endTime;
  final MedicineType? medicineType;
  final DoseType? doseType;
  final int? doseAmount;
  final String? note;
  final bool? isDone;

  const MedicationReminder({
    required this.medicationId,
    required this.medicationName,
    this.imageUrl,
    this.startTime,
    this.endTime,
    this.medicineType,
    this.doseType,
    this.doseAmount,
    this.note,
    this.isDone,
  });

  MedicationReminder copyWith({
    String? medicationId,
    String? medicationName,
    String? imageUrl,
    DateTime? startTime,
    DateTime? endTime,
    MedicineType? medicineType,
    DoseType? doseType,
    int? doseAmount,
    String? note,
    bool? isDone,
  }) {
    return MedicationReminder(
      medicationId: medicationId ?? this.medicationId,
      medicationName: medicationName ?? this.medicationName,
      imageUrl: imageUrl ?? this.imageUrl,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      medicineType: medicineType ?? this.medicineType,
      doseType: doseType ?? this.doseType,
      doseAmount: doseAmount ?? this.doseAmount,
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
      medicineType: MedicineTypeExtension.fromInt(json['medicine_type']),
      doseType: DoseTypeExtension.fromInt(json['dose_type']),
      doseAmount: json['dose_amount'],
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
      'medicine_type':
          MedicineTypeExtension.toInt(medicineType ?? MedicineType.Tablet),
      'dose_type': DoseTypeExtension.toInt(doseType ?? DoseType.pills),
      'dose_amount': doseAmount,
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
        medicineType,
        doseType,
        doseAmount,
        note,
        isDone,
      ];
}
