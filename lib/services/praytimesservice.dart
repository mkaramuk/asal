import 'dart:convert';

import 'package:asal/models/calendar.dart';
import 'package:dio/dio.dart';

class PrayTimeService {
  static Future<Calendar> getTimes() async {
    Response r = await Dio().get(
        "https://api.aladhan.com/v1/calendarByCity/2023/05?city=Istanbul&country=Turkey&state=Istanbul&method=13");

    return Calendar.fromJson(r.data);
  }
}
