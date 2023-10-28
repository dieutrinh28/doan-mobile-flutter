import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:medicine_reminder/config/common_enum.dart';
import 'package:medicine_reminder/model/medication_reminder.dart';
import 'package:medicine_reminder/service/medication_service.dart';

part 'tracker_event.dart';
part 'tracker_state.dart';

class TrackerBloc extends Bloc<TrackerEvent, TrackerState> {
  TrackerBloc() : super(TrackerState.initial()) {
    on<GetAllTrackerEvent>((event, emit) async {
      final MedicationService service = MedicationService();
      final List<MedicationReminder> list = await service.getAllTracker();
      final TrackerStatus status;
      try {
        if (list.isNotEmpty) {
          status = TrackerStatus.success;
        } else {
          status = TrackerStatus.error;
        }
        emit(state.copyWith(
          status: status,
          list: list,
        ));
      } catch (e) {
        emit(
          state.copyWith(
            status: TrackerStatus.error,
            list: list,
            error: e.toString(),
          ),
        );
      }
    });

    on<GetTrackerByDateTimeEvent>((event, emit) async {
      final MedicationService service = MedicationService();
      final List<MedicationReminder> list =
          await service.getTrackerByDateTime(event.dateTime);
      try {
        emit(state.copyWith(
          status: TrackerStatus.success,
          list: list,
        ));
      } catch (e) {
        emit(
          state.copyWith(
            status: TrackerStatus.error,
            list: list,
            error: e.toString(),
          ),
        );
      }
    });

    on<ToggleCheckTrackerEvent>((event, emit) {});

    on<CreateMedicationEvent>((event, emit) async {
      final MedicationService service = MedicationService();
      try {
        await service.createTracker(
          medicationName: event.medicationName,
          startTime: event.startDate,
          endTime: event.endDate,
          medicineType: event.medicineType,
          doseType: event.doseType,
          doseAmount: event.doseAmount,
          note: event.note,
        );
        emit(state.copyWith(
          status: TrackerStatus.success,
        ));
      } catch (e) {
        emit(
          state.copyWith(
            status: TrackerStatus.error,
            error: e.toString(),
          ),
        );
      }
    });
  }
}
