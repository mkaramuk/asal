import 'dart:async';

import 'package:asal/dialogs/update_times/update_times_view.dart';
import 'package:asal/extensions/date_extensions.dart';
import 'package:asal/models/calendar_model.dart';
import 'package:asal/models/day_model.dart';
import 'package:asal/services/config_service.dart';
import 'package:asal/services/praytimes_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomepageCubit extends Cubit<HomepageState> {
  HomepageCubit(this.context) : super(HomepageLoading()) {
    _loadCalendar();
  }
  BuildContext context;
  CalendarModel? calendar;
  late Timer timer;

  Future<bool?> showUpdateTimesDialog() async {
    return showDialog<bool>(context: context, builder: (context) => UpdateTimesDialog);
  }

  Future<void> _loadCalendar() async {
    bool? updated = false;
    calendar = await ConfigService.loadCalendar();
    if (calendar == null) {
      do {
        updated = await Future.microtask(() => showUpdateTimesDialog());
      } while (updated != null && !updated);
      calendar = await ConfigService.loadCalendar();
    }
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
    DayModel today = calendar!.today();
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
