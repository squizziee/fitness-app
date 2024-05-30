import 'dart:async';

import 'package:flutter_fitness_app/models/training_types.dart';
import 'package:flutter_fitness_app/models/training_session.dart';
import 'package:flutter_fitness_app/services/notfication_service.dart';
import 'package:flutter_fitness_app/services/regiment_service.dart';

class TrainingRegiment {
  dynamic id;
  String? name = "";
  String? notes = "";
  TrainingType? trainingType;
  List<TrainingSession>? schedule = [];
  List<int>? notificationIdList = [];
  Timer? _launchNotificationTimer;
  Timer? _notificationTimer;
  DateTime? launchTime;

  final NotificationService _notificationService = NotificationService();

  DateTime? startDate;
  int dayOfPause = -1;
  int? cycleDurationInDays = 0;

  TrainingRegiment(
      {this.name,
      this.id,
      this.notes,
      this.trainingType,
      this.schedule,
      this.notificationIdList,
      this.startDate,
      this.cycleDurationInDays,
      required this.dayOfPause});

  int getCurrentDay() {
    if (startDate == null) {
      return -1;
    }
    if (isPaused()) {
      return dayOfPause;
    }
    if (DateTime.now().difference(startDate!).inDays > cycleDurationInDays!) {
      startDate = null;
      dayOfPause = -1;
      return -1;
    }
    return DateTime.now().difference(startDate!).inDays % cycleDurationInDays!;
  }

  bool isPaused() {
    return dayOfPause != -1;
  }

  // void initNotificationLaunchTime() {
  //   var now = DateTime.now();
  //   if (startDate != null) {
  //     // if it is before 8 am
  //     if (now.hour < 8) {
  //       launchTime = now
  //           .subtract(Duration(
  //               hours: now.hour, minutes: now.minute, seconds: now.second))
  //           .add(const Duration(hours: 8));
  //       // if it is after after 8 am
  //     } else if (now.hour >= 8) {
  //       launchTime = now
  //           .add(const Duration(days: 1))
  //           .subtract(Duration(
  //               hours: now.hour, minutes: now.minute, seconds: now.second))
  //           .add(const Duration(hours: 8));
  //     }
  //     launchTime = now.add(const Duration(seconds: 10));
  //   }
  // }

  // void startNotifications() {
  //   var now = DateTime.now();

  //   _launchNotificationTimer = Timer(launchTime!.difference(now), () {
  //     var session = schedule![getCurrentDay()];
  //     _notificationTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
  //       _notificationService.instantNotify("Today`s training session on $name",
  //           "Session #${session.dayInSchedule} (${session.name == "" ? "No name" : session.name}) is to perform today");
  //     });
  //   });
  // }

  // void cancelNotifications() {
  //   if (_notificationTimer != null) {
  //     _notificationTimer!.cancel();
  //     return;
  //   }
  //   _launchNotificationTimer!.cancel();
  // }
}
