extension DateExtensions on DateTime {
  bool isBetween(DateTime a, DateTime b) {
    return isAfter(a) && isBefore(b);
  }

  get timeInSeconds {
    return (hour * 60 * 60) + (minute * 60) + second;
  }

  String toDifferenceString(DateTime b) {
    if (b.timeInSeconds < timeInSeconds) {
      b = b.add(const Duration(days: 1));
    }
    Duration diff = difference(b);
    String hours = diff.inHours.abs().toString().padLeft(2, '0');
    String minutes = (diff.inMinutes - (diff.inHours * 60)).abs().toString().padLeft(2, '0');
    String seconds = (diff.inSeconds - diff.inMinutes * 60).abs().toString().padLeft(2, '0');

    return "$hours:$minutes:$seconds";
  }
}
