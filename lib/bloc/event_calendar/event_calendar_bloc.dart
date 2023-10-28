import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:medicine_reminder/model/event_calendar.dart';
import 'package:medicine_reminder/service/calender_service.dart';

part 'event_calendar_event.dart';
part 'event_calendar_state.dart';

class EventCalendarBloc extends Bloc<EventCalendarEvent, EventCalendarState> {
  EventCalendarBloc() : super(EventCalendarState.initial()) {
    on<GetEventCalendarByDateTimeEvent>((event, emit) async {
      final CalendarService calendarService = CalendarService();
      final List<EventCalendar>? list =
          await calendarService.getEventCalendarByDateTime(
        event.dateTime,
        event.accessToken,
      );
      final EventCalendarStatus status;

      try {
        if (list != null) {
          status = EventCalendarStatus.success;
        } else {
          status = EventCalendarStatus.error;
        }
        emit(state.copyWith(
          status: status,
          list: list,
        ));
      } catch (e) {
        emit(
          state.copyWith(
            status: EventCalendarStatus.error,
            list: list,
            error: e.toString(),
          ),
        );
      }
    });

    on<GetAllEventCalendarEvent>((event, emit) async {
      final CalendarService calendarService = CalendarService();
      final List<EventCalendar>? list =
          await calendarService.fetchCalendarEvents(
        event.accessToken,
      );
      final EventCalendarStatus status;

      try {
        if (list != null) {
          status = EventCalendarStatus.success;
        } else {
          status = EventCalendarStatus.error;
        }
        emit(state.copyWith(
          status: status,
          list: list,
        ));
      } catch (e) {
        emit(
          state.copyWith(
            status: EventCalendarStatus.error,
            list: list,
            error: e.toString(),
          ),
        );
      }
    });

    on<CreateEventCalendarEvent>((event, emit) async {
      final CalendarService calendarService = CalendarService();
      try {
        await calendarService.createEventCalendar(
          medicationName: event.medicationName,
          startDate: event.startDate,
          startTime: event.startTime,
          endDate: event.endDate,
          endTime: event.endTime,
          accessToken: event.accessToken,
        );
        emit(
          state.copyWith(
            status: EventCalendarStatus.success,
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            status: EventCalendarStatus.error,
            error: e.toString(),
          ),
        );
      }
    });
  }
}
