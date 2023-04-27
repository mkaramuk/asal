extension DateExtensions on DateTime {
  bool isBetween(DateTime a, DateTime b) {
    return isAfter(a) && isBefore(b);
  }
}
