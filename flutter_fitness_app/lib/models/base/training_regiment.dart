import 'dart:math';

import 'package:flutter_fitness_app/models/base/training_types.dart';
import 'package:flutter_fitness_app/models/base/training_session.dart';
import 'package:flutter_fitness_app/services/notfication_service.dart';

class TrainingRegiment {
  dynamic id;
  String? name = "";
  String? notes = "";
  TrainingType? trainingType;
  List<TrainingSession>? schedule = [];
  List<int>? notificationIdList = [];

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

  void startNotifications(int startingFromIndex) {
    var now = DateTime.now();

    var notificationDateTime = now
        .subtract(
            Duration(hours: now.hour, minutes: now.minute, seconds: now.second))
        .add(const Duration(hours: 8));

    // var dummyDateTime = now.add(const Duration(seconds: 5));

    for (var i = startingFromIndex; i < schedule!.length; i++) {
      var session = schedule![i];
      var id = Random().nextInt(0x7FFFFFF1);
      notificationIdList!.add(id);
      _notificationService.scheduleNotification(
          "Today`s training session on $name",
          "Session #${session.dayInSchedule + 1} (${session.name == "" ? "No name" : session.name}) is to perform today",
          notificationDateTime.add(Duration(days: i)),
          id);
    }
  }

  String? getMainStatistic() {
    if (trainingType is WeightTraining) {
      if (cycleDurationInDays! < 7) {
        return null;
      }
      var workDays = 0;
      for (var i = 0; i < 7; i++) {
        var session = schedule![i];
        if (session.exercises.isNotEmpty) {
          ++workDays;
        }
      }
      return "$workDays ${workDays % 10 == 1 ? "day" : "days"} a week";
    }
    return null;
  }

  void cancelNotifications() {
    for (var id in notificationIdList!) {
      _notificationService.cancelScheduledNotification(id);
    }

    notificationIdList!.clear();
  }
}
