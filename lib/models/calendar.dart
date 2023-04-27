import 'dart:ffi';

import 'package:asal/models/day.dart';

class Calendar {
  final List<Day> days;

  Calendar(this.days);

  Calendar.fromJson(Map<String, dynamic> json)
      : days = List<Day>.from((json['data'] as Iterable).map((e) => Day.fromJson(e)));

  Day today() {
    DateTime now = DateTime.now();
    return days.firstWhere((element) {
      return element.date.day == now.day &&
          element.date.month == now.month &&
          element.date.year == now.year;
    });
  }
}
