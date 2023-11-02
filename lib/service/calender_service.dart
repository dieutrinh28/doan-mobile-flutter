import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:medicine_reminder/model/event_calendar.dart';
import 'package:medicine_reminder/service/calendar_auth.dart';
import 'package:http/http.dart' as http;

class CalendarService {
  final apiKey = 'AIzaSyBntsivPGnjK6aJZH4dNk0weDUpWCiOzKY';
  final calendarId = 'primary';

  Future<void> listEvents() async {
    final client = await CalendarAuth.obtainAuthenticatedClient();

    final calendarApi = CalendarApi(client);

    final events = await calendarApi.events.list('primary');

    for (var event in events.items!) {
      print('Event: ${event.summary}');
    }

    client.close();
  }

  Future<void> createEvent() async {
    final client = await CalendarAuth.obtainAuthenticatedClient();

    final calendarApi = CalendarApi(client);

    final event = Event()
      ..summary = 'New Event'
      ..description = 'Description'
      ..start = EventDateTime(dateTime: DateTime.now())
      ..end =
          EventDateTime(dateTime: DateTime.now().add(const Duration(hours: 1)));

    final result = await calendarApi.events.insert(event, 'primary');

    print('Event created: ${result.summary}');

    client.close();
  }

  Future<void> deleteEvent(String eventId) async {
    final client = await CalendarAuth.obtainAuthenticatedClient();

    final calendarApi = CalendarApi(client);

    await calendarApi.events.delete('primary', eventId);

    print('Event deleted with ID: $eventId');

    client.close();
  }

  Future<List<EventCalendar>?> fetchCalendarEvents(String accessToken) async {
    final url = Uri.parse(
        'https://www.googleapis.com/calendar/v3/calendars/$calendarId/events?key=$apiKey');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final events = data['items'] as List;
      return events
          .map((eventData) => EventCalendar.fromJson(eventData))
          .toList();
    } else {
      throw Exception(
          'Failed to fetch calendar events. Status Code: ${response.statusCode}');
    }
  }

  Future<List<EventCalendar>?> getEventCalendarByDateTime(
    DateTime dateTime,
    String accessToken,
  ) async {
    final start = dateTime.toUtc().toIso8601String();
    final end = dateTime.add(Duration(days: 1)).toUtc().toIso8601String();

    final url = Uri.parse(
        'https://www.googleapis.com/calendar/v3/calendars/$calendarId/events?key=$apiKey&timeMin=$start&timeMax=$end');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final events = data['items'] as List;
      return events
          .map((eventData) => EventCalendar.fromJson(eventData))
          .toList();
    } else {
      throw Exception(
          'Failed to fetch calendar events. Status Code: ${response.statusCode}');
    }
  }

  Future<void> createEventCalendar({
    required String medicationName,
    required DateTime startDate,
    required TimeOfDay startTime,
    required DateTime endDate,
    required TimeOfDay endTime,
    required String accessToken,
  }) async {
    final start = DateTime(
      startDate.year,
      startDate.month,
      startDate.day,
      startTime.hour,
      startTime.minute,
    ).toUtc().toIso8601String();

    final end = DateTime(
      endDate.year,
      endDate.month,
      endDate.day,
      endTime.hour,
      endTime.minute,
    ).toUtc().toIso8601String();

    final url = Uri.parse(
        'https://www.googleapis.com/calendar/v3/calendars/$calendarId/events?key=$apiKey');

    final requestBody = json.encode({
      'summary': medicationName,
      'start': {
        'dateTime': start,
        'timeZone': 'Asia/Ho_Chi_Minh'
      },
      'end': {
        'dateTime': end,
        'timeZone': 'Asia/Ho_Chi_Minh'
      },
      'description': "Đến giờ uống thuốc rồi",
      'recurrence': [
        'RRULE:FREQ=DAILY;COUNT=5',
      ],
      'reminders': {
        'useDefault': true,
      }
    });

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
      body: requestBody,
    );

    if (response.statusCode == 200) {
      print('Create successfully');
      print(response.body);
    } else {
      print("Error: ${response.statusCode}");
      print("${response.body.toString()}");
      throw Exception(
          'Failed to create calendar event. Status Code: ${response.statusCode}');
    }
  }
}
