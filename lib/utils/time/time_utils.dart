import 'package:intl/intl.dart';

class TimeUtils {
  static bool hasTimeExpired(String inputTime) {
    if (inputTime.isEmpty) {
      return false;
    }

    try {
      DateTime parsedInputTime = DateTime.parse(inputTime);
      DateTime currentTime = DateTime.now();
      return parsedInputTime.isBefore(currentTime);
    } catch (e) {
      return false;
    }
  }

  static String getTimeDifference(String inputTime) {
    if (inputTime.isEmpty) {
      return 'Invalid Time';
    }

    try {
      DateTime parsedInputTime = DateTime.parse(inputTime);
      DateTime currentTime = DateTime.now();
      Duration difference = parsedInputTime.difference(currentTime);
      difference = difference.isNegative ? Duration() : difference;

      return formatDuration(difference);
    } catch (e) {
      return 'Invalid Time';
    }
  }

  static String formatDuration(Duration duration) {
    int hours = duration.inHours;
    int minutes = (duration.inMinutes % 60);
    int seconds = (duration.inSeconds % 60);

    return '$hours:${_twoDigits(minutes)}:${_twoDigits(seconds)}';
  }

  static String _twoDigits(int n) {
    if (n >= 10) {
      return "$n";
    } else {
      return "0$n";
    }
  }

  static String convertDateFormat(String inputDate) {
    // Split the input date into day, month, and year
    List<String> dateComponents = inputDate.split('/');

    // Check if the input date has three components (day, month, year)
    if (dateComponents.length == 3) {
      // Rearrange the components to form the "YYYY-MM-DD" format
      String year = dateComponents[2];
      String month = dateComponents[1];
      String day = dateComponents[0];

      // Concatenate the components with "-" separator
      String outputDate = "$year-$month-$day";

      return outputDate;
    } else {
      // If the input date format is incorrect, return an error message or handle accordingly
      return "Invalid date format";
    }
  }

  static String convertDateFormatApiToDayMonthYear(String originalDateString) {
  // Parse the original date string
  DateTime originalDate = DateTime.parse(originalDateString);

  // Format the date in the desired format
  String formattedDate = DateFormat('dd/MM/yyyy').format(originalDate);

  return formattedDate;
}
}
