import 'dart:convert';
import 'dart:ffi';

import 'package:asal/models/day_model.dart';

class CalendarModel {
  final List<DayModel> days;

  CalendarModel(this.days);

  CalendarModel.fromJson(Map<String, dynamic> json)
      : days = List<DayModel>.from((json['data'] as Iterable).map((e) => DayModel.fromJson(e)));

  Map<String, dynamic> toJson() => {"data": days};

  DayModel today() {
    DateTime now = DateTime.now();
    return days.firstWhere((element) {
      return element.date.value.day == now.day &&
          element.date.value.month == now.month &&
          element.date.value.year == now.year;
    });
  }
}
