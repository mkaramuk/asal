import 'package:asal/models/calendar_model.dart';
import 'package:dio/dio.dart';

class PrayTimeService {
  static Future<CalendarModel> getTimes(
      int year, int month, String country, String city, String region) async {
    Response r = await Dio().get(
        "https://api.aladhan.com/v1/calendarByCity/$year/$month?city=$city&country=$country&state=$region&method=13");

    return CalendarModel.fromJson(r.data);
  }
}
