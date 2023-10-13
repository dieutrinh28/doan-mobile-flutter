import 'package:intl/intl.dart';

class MedicineUtil {
  static String formatDateTime(DateTime dateTime) {
    return DateFormat('EEEE dd MMMM').format(dateTime);
  }
}