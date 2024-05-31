// ignore_for_file: unused_field

import 'dart:math';

import 'package:flutter_fitness_app/models/weight_training/weight_exercise_type.dart';
import 'package:flutter_fitness_app/services/notfication_service.dart';

class Goal {
  dynamic id;
  DateTime? deadline;
  WeightExerciseType? exerciseType;
  Set<GoalMetric>? metrics;
  int? notificationId;

  final NotificationService _notificationService = NotificationService();

  Goal(
      {this.id,
      this.deadline,
      this.exerciseType,
      this.metrics,
      this.notificationId});

  @override
  operator ==(other) {
    return other is Goal &&
        deadline == other.deadline &&
        //metrics!.difference(other.metrics!).isEmpty &&
        exerciseType!.name == other.exerciseType!.name;
  }

  void startNotifications() {
    var id = Random().nextInt(0x7FFFFFF1);
    _notificationService.scheduleNotification(
        "Goal for '${exerciseType == null ? "" : exerciseType!.name}' is due",
        "It is ${deadline == null ? "" : deadline!} already!",
        deadline!,
        id);
  }

  void cancelNotifications() {
    if (notificationId == null) return;
    _notificationService.cancelScheduledNotification(notificationId!);
    notificationId = null;
  }
}

class GoalMetric {
  String? metricName;
  double? metricSize;
  String? metricScale = "";

  GoalMetric({this.metricName, this.metricSize, this.metricScale});

  @override
  operator ==(other) {
    return other is GoalMetric &&
        metricName == other.metricName &&
        metricScale == other.metricScale &&
        metricSize == other.metricSize;
  }

  @override
  int get hashCode =>
      metricName.hashCode - metricScale.hashCode + metricSize.hashCode << 2;
}
