import 'package:intl/intl.dart';

String _parseTime(String time) {
  return time.split(' ')[0];
}

var _timeFormat = DateFormat("HH:mm");

DateTime _parseWithDate(String time) {
  DateTime date = _timeFormat.parse(time);
  DateTime now = DateTime.now();
  return DateTime(now.year, now.month, now.day, date.hour, date.minute);
}

class Day {
  final DateTime date;
  final DateTime fajr;
  final DateTime sunrise;
  final DateTime dhuhr;
  final DateTime asr;
  final DateTime maghrib;
  final DateTime isha;

  Day(this.date, this.fajr, this.sunrise, this.dhuhr, this.asr, this.maghrib, this.isha);

  Day.fromJson(Map<String, dynamic> json)
      : date = DateFormat("dd-MM-yyyy").parse(json["date"]["gregorian"]["date"]),
        fajr = _parseWithDate(_parseTime(json["timings"]["Fajr"])),
        sunrise = _parseWithDate(_parseTime(json["timings"]["Sunrise"])),
        dhuhr = _parseWithDate(_parseTime(json["timings"]["Dhuhr"])),
        asr = _parseWithDate(_parseTime(json["timings"]["Asr"])),
        maghrib = _parseWithDate(_parseTime(json["timings"]["Maghrib"])),
        isha = _parseWithDate(_parseTime(json["timings"]["Isha"]));
}
