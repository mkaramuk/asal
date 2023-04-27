import 'dart:async';

import 'package:asal/extensions/date_extensions.dart';
import 'package:asal/models/calendar.dart';
import 'package:asal/models/day.dart';
import 'package:asal/services/praytimesservice.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomepageCubit extends Cubit<HomepageState> {
  HomepageCubit() : super(HomepageLoading()) {
    _loadCalendar();
  }
  Calendar? calendar;
  late Timer timer;

  Future<void> _loadCalendar() async {
    calendar = await PrayTimeService.getTimes();
    timer = Timer.periodic(const Duration(seconds: 1), (Timer _) {
      emit(HomepageLoaded());
    });
  }

  String get timeLeft {
    Duration difference = nextTime.difference(DateTime.now());
    String hours = difference.inHours.toString().padLeft(2, '0');
    String minutes = (difference.inMinutes - (difference.inHours * 60)).toString().padLeft(2, '0');
    String seconds = (difference.inSeconds - difference.inMinutes * 60).toString().padLeft(2, '0');

    return "$hours:$minutes:$seconds";
  }

  DateTime get nextTime {
    DateTime now = DateTime.now();
    Day today = calendar!.today();
    if (now.isBetween(today.fajr, today.sunrise)) {
      return today.sunrise;
    } else if (now.isBetween(today.sunrise, today.dhuhr)) {
      return today.dhuhr;
    } else if (now.isBetween(today.dhuhr, today.asr)) {
      return today.asr;
    } else if (now.isBetween(today.asr, today.maghrib)) {
      return today.maghrib;
    } else if (now.isBetween(today.maghrib, today.isha)) {
      return today.isha;
    } else /*if (now.isBetween(today.isha, today.fajr)) */ {
      return today.fajr;
    }
  }
}

abstract class HomepageState {}

class HomepageLoaded extends HomepageState {}

class HomepageLoading extends HomepageState {}
