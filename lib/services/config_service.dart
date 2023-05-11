import 'dart:convert';

import 'package:asal/models/calendar_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigService {
  static Future<void> saveCalendar(CalendarModel calendar) async {
    final currentPrefs = await SharedPreferences.getInstance();
    await currentPrefs.setString("calendar", jsonEncode(calendar.toJson()));
  }

  static Future<CalendarModel?> loadCalendar() async {
    final currentPrefs = await SharedPreferences.getInstance();
    String? calendarJson = currentPrefs.getString("calendar");

    if (calendarJson == null || calendarJson == "") {
      return null;
    }

    return CalendarModel.fromJson(jsonDecode(calendarJson));
  }
}
