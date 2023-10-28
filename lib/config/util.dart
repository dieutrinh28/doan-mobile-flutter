import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/cloudsearch/v1.dart';
import 'package:intl/intl.dart';

class MedicineUtil {
  static String formatDateTime(DateTime dateTime) {
    return DateFormat('EEEE dd MMMM').format(dateTime);
  }

  static DateTime convertTimestampToDateTime(Timestamp timestamp) {
    return timestamp.toDate();
  }

  static Timestamp convertDateTimeToTimestamp(DateTime dateTime) {
    return Timestamp.fromDate(dateTime);
  }

  static String formatDateTimeToString(DateTime dateTime) {
    return DateFormat('MM-dd-yyyy HH:mm').format(dateTime);
  }

  static String formatDateTimeOfDay(DateTime dateTime, TimeOfDay timeOfDay) {
    return '${DateFormat('MM-dd-yyyy').format(dateTime)} ${formatTimeOfDay(timeOfDay)}';
  }

  static String formatTimeOfDay(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}