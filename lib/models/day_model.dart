import 'package:asal/models/time_model.dart';
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

class DayModel {
  final TimeModel date = TimeModel(DateTime.now(), "Tarih");
  final TimeModel fajr = TimeModel(DateTime.now(), "İmsak", image: "assets/images/evening.jpg");
  final TimeModel sunrise = TimeModel(DateTime.now(), "Güneş", image: "assets/images/morning.jpg");
  final TimeModel dhuhr = TimeModel(DateTime.now(), "Öğle", image: "assets/images/noon.jpg");
  final TimeModel asr = TimeModel(DateTime.now(), "İkindi", image: "assets/images/morning.jpg");
  final TimeModel maghrib = TimeModel(DateTime.now(), "Akşam", image: "assets/images/evening.jpg");
  final TimeModel isha = TimeModel(DateTime.now(), "Yatsı", image: "assets/images/night.jpg");

  DayModel();

  factory DayModel.fromJson(Map<String, dynamic> json) {
    DayModel day = DayModel();

    day.date.value = DateFormat("dd-MM-yyyy").parse(json["date"]["gregorian"]["date"]);
    day.fajr.value = _parseWithDate(_parseTime(json["timings"]["Fajr"]));
    day.sunrise.value = _parseWithDate(_parseTime(json["timings"]["Sunrise"]));
    day.dhuhr.value = _parseWithDate(_parseTime(json["timings"]["Dhuhr"]));
    day.asr.value = _parseWithDate(_parseTime(json["timings"]["Asr"]));
    day.maghrib.value = _parseWithDate(_parseTime(json["timings"]["Maghrib"]));
    day.isha.value = _parseWithDate(_parseTime(json["timings"]["Isha"]));
    return day;
  }

  Map<String, dynamic> toJson() => {
        "date": {
          "gregorian": {"date": DateFormat("dd-MM-yyyy").format(date.value)}
        },
        "timings": {
          "Fajr": _timeFormat.format(fajr.value),
          "Sunrise": _timeFormat.format(sunrise.value),
          "Dhuhr": _timeFormat.format(dhuhr.value),
          "Asr": _timeFormat.format(asr.value),
          "Maghrib": _timeFormat.format(maghrib.value),
          "Isha": _timeFormat.format(isha.value),
        }
      };
}
