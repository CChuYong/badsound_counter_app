import 'package:intl/intl.dart';

class DateParser {
  static DateFormat dateTimeFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
  static DateFormat dateFormat = DateFormat('yyyy.MM.dd.');
  static DateFormat lastMessageTimeFormat = DateFormat("a hh:mm");

  static DateTime fromTimeStamp(int timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp, isUtc: false);
  }

  static String timeStampAsDateTime(int timestamp) {
    return dateTimeFormat.format(fromTimeStamp(timestamp));
  }

  static String timeStampAsDate(int timestamp) {
    return dateFormat.format(fromTimeStamp(timestamp));
  }

  static String lastMessageFormat(int timestamp) {
    return lastMessageTimeFormat.format(fromTimeStamp(timestamp));
  }
}
