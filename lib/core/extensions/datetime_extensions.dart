extension DateTimeExtensions on DateTime {
  // Extension method to convert DateTime to String
  String toDateString() {
    return "$day/$month/$year";
  }
}

extension StringExtensions on String {
  // Extension method to convert String to DateTime
  DateTime toDateTime() {
    var parts = split('/');
    return DateTime(
        int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
  }
}

extension DateTimeExtension on String {
  DateTime? toDateTimeObject() {
    try {
      return DateTime.parse(this);
    } catch (e) {
      // Try parsing in 'dd/MM/yyyy' format
      final parts = split('/');
      if (parts.length == 3) {
        return DateTime(
            int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
      }
      return null;
    }
  }
}
