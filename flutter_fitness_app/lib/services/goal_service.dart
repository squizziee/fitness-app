import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/base/goal.dart';
import 'package:flutter_fitness_app/models/base/user.dart';
import 'package:flutter_fitness_app/models/weight_training/weight_exercise_type.dart';
import 'package:flutter_fitness_app/repos/current_goal.dart';
import 'package:flutter_fitness_app/services/database_service.dart';
import 'package:flutter_fitness_app/services/notfication_service.dart';
import 'package:provider/provider.dart';

class GoalService {
  final DatabaseService _dbService = DatabaseService();
  final NotificationService _notificationService = NotificationService();
  Future<void> createAndOpenEmptyGoal(BuildContext context) async {
    var user = Provider.of<AppUser>(context, listen: false);
    var goal = Goal(metrics: <GoalMetric>{});
    user.goals!.add(goal);

    Provider.of<CurrentGoal>(context, listen: false).goal = goal;
    await _saveGoalToDatabase(context);
  }

  void openGoal(BuildContext context, int goalIndex) {
    var goals = Provider.of<AppUser>(context, listen: false).goals;
    Provider.of<CurrentGoal>(context, listen: false).goal = goals![goalIndex];
  }

  void removeGoalByIndex(BuildContext context, int goalIndex) {
    Provider.of<AppUser>(context, listen: false)
        .goals![goalIndex]
        .cancelNotifications();

    var goals = Provider.of<AppUser>(context, listen: false).goals;
    goals!.removeAt(goalIndex);
    var user = Provider.of<AppUser>(context, listen: false);
    _dbService.postAppUser(user);
  }

  void openGoalByReference(BuildContext context, Goal goal) {
    Provider.of<CurrentGoal>(context, listen: false).goal = goal;
  }

  Future updateDeadline(BuildContext context, DateTime newDeadline) async {
    Provider.of<CurrentGoal>(context, listen: false).goal!.deadline =
        newDeadline;
    await _saveGoalToDatabase(context);
  }

  Future updateExercise(
      BuildContext context, WeightExerciseType? newExerciseType) async {
    if (newExerciseType == null) {
      return;
    }
    Provider.of<CurrentGoal>(context, listen: false).goal!.exerciseType =
        newExerciseType;
    await _saveGoalToDatabase(context);
  }

  void _startNotifications(BuildContext context) {
    var goal = Provider.of<CurrentGoal>(context, listen: false).goal!;

    var id = Random().nextInt(0x7FFFFFF1);
    _notificationService.scheduleNotification(
        "Goal for '${goal.exerciseType == null ? "" : goal.exerciseType!.name}' is due",
        "It is ${goal.deadline == null ? "" : goal.deadline!} already!",
        goal.deadline!,
        id);
  }

  void _cancelNotifications(BuildContext context) {
    var goal = Provider.of<CurrentGoal>(context, listen: false).goal!;
    goal.notificationId = null;
  }

  Future addMetric(BuildContext context, String metric, double metricSize,
      {String metricScale = ""}) async {
    Provider.of<CurrentGoal>(context, listen: false).goal!.metrics!.add(
        GoalMetric(
            metricName: metric,
            metricSize: metricSize,
            metricScale: metricScale));
    await _saveGoalToDatabase(context);
  }

  // TODO not working
  Future deleteMetric(BuildContext context, String metricName) async {
    var metric = Provider.of<CurrentGoal>(context, listen: false)
        .goal!
        .metrics!
        .where((metric) => metric.metricName == metricName);
    Provider.of<CurrentGoal>(context, listen: false)
        .goal!
        .metrics!
        .remove(metric);
    await _saveGoalToDatabase(context);
  }

  Future deleteMetricByIndex(BuildContext context, int index) async {
    var metrics =
        Provider.of<CurrentGoal>(context, listen: false).goal!.metrics!;
    metrics.remove(metrics.elementAt(index));
    await _saveGoalToDatabase(context);
  }

  Future _saveGoalToDatabase(context) async {
    var goal = Provider.of<CurrentGoal>(context, listen: false).goal!;

    if (goal.deadline == null) return;
    if (goal.exerciseType == null) return;

    goal.cancelNotifications();
    goal.startNotifications();

    var user = Provider.of<AppUser>(context, listen: false);
    await _dbService.postGoal(goal);
    await _dbService.postAppUser(user);
  }
}
