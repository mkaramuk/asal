import 'dart:async';

import 'package:asal/dialogs/update_times/update_times_view.dart';
import 'package:asal/extensions/date_extensions.dart';
import 'package:asal/models/calendar_model.dart';
import 'package:asal/models/day_model.dart';
import 'package:asal/models/time_model.dart';
import 'package:asal/services/config_service.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomepageCubit extends Cubit<HomepageState> {
  HomepageCubit(this.context) : super(HomepageLoading()) {
    _loadCalendar();
  }
  int cardIndex = 0;
  int nextTimeIndex = 0;
  TimeModel nextTime = TimeModel(DateTime.now(), "Vakit");
  DayModel today = DayModel();
  BuildContext context;
  CalendarModel? calendar;
  List<TimeModel> prayTimes = [];
  CarouselController carouselController = CarouselController();
  late Timer timer;
  late TimeModel lastTime;

  void onCardChanged(int index, CarouselPageChangedReason reason) {
    cardIndex = index;
    emit(HomepageLoaded());
  }

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

    today = calendar!.today();
    findNextTime();
    lastTime = nextTime;
    cardIndex = nextTimeIndex;
    emit(HomepageLoaded());

    timer = Timer.periodic(const Duration(seconds: 1), (Timer _) {
      checkToday();
      findNextTime();
      checkTimeChange();
      emit(HomepageLoaded());
    });
  }

  String get timeLeft {
    if (prayTimes.isEmpty) {
      return "00:00:00";
    }

    return DateTime.now().toDifferenceString(prayTimes[cardIndex].value);
  }

  void checkTimeChange() {
    if (lastTime.name != nextTime.name) {
      lastTime = nextTime;
      cardIndex = nextTimeIndex;
      carouselController.animateToPage(cardIndex,
          duration: const Duration(seconds: 1), curve: Curves.easeInOut);
    }
  }

  void findNextTime() {
    prayTimes = [today.fajr, today.sunrise, today.dhuhr, today.asr, today.maghrib, today.isha];
    DateTime now = DateTime.now();

    for (int i = 1; i < prayTimes.length; i++) {
      if (now.isBetween(prayTimes[i - 1].value, prayTimes[i].value)) {
        nextTime = prayTimes[i];
        nextTimeIndex = i;
        return;
      }
    }

    nextTime = prayTimes[0];
    nextTimeIndex = 0;
  }

  void checkToday() {
    if (DateTime.now().day != today.date.value.day) {
      today = calendar!.today();
    }
  }
}

abstract class HomepageState {}

class HomepageLoaded extends HomepageState {}

class HomepageLoading extends HomepageState {}
