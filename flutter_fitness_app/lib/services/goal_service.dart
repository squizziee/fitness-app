import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/goal.dart';
import 'package:flutter_fitness_app/models/user.dart';
import 'package:flutter_fitness_app/repos/current_goal.dart';
import 'package:provider/provider.dart';

class GoalService {
  void openGoal(BuildContext context, int goalIndex) {
    var goals = Provider.of<AppUser>(context, listen: false).goals;
    Provider.of<CurrentGoal>(context, listen: false).goal = goals![goalIndex];
  }

  void changeDeadline(BuildContext context, DateTime newDeadline) {
    var oldDeadline =
        Provider.of<CurrentGoal>(context, listen: false).goal!.deadline;
    assert(oldDeadline!.isBefore(newDeadline));
    oldDeadline = newDeadline;
  }

  void changeExercise(BuildContext context, String newExerciseName) {
    Provider.of<CurrentGoal>(context, listen: false).goal!.exerciseName =
        newExerciseName;
  }

  void addMetric(BuildContext context, String metric, double metricSize,
      {String metricScale = ""}) {
    Provider.of<CurrentGoal>(context, listen: false).goal!.metrics!.add(
        GoalMetric(
            metricName: metric,
            metricSize: metricSize,
            metricScale: metricScale));
  }

  void deleteMetric(BuildContext context, String metricName) {
    var metric = Provider.of<CurrentGoal>(context, listen: false)
        .goal!
        .metrics!
        .where((metric) => metric.metricName == metricName);
    Provider.of<CurrentGoal>(context, listen: false)
        .goal!
        .metrics!
        .remove(metric);
  }
}
