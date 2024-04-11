// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/goal.dart';
import 'package:flutter_fitness_app/models/training_regiment.dart';

class AppUser extends ChangeNotifier {
  String? userUID;
  List<Goal>? goals = [
    Goal(
        deadline: DateTime(2024, 4, 1),
        exerciseName: "Barbell Bench Press",
        metrics: {
          GoalMetric(metricName: "repetitions", metricSize: 15),
          GoalMetric(metricName: "weight", metricSize: 100, metricScale: "kg")
        }),
    Goal(
        deadline: DateTime(2024, 7, 1),
        exerciseName: "Barbell Bench Press",
        metrics: {
          GoalMetric(metricName: "repetitions", metricSize: 12),
          GoalMetric(metricName: "weight", metricSize: 105, metricScale: "kg")
        }),
    Goal(
        deadline: DateTime(2024, 8, 1),
        exerciseName: "Barbell Squat",
        metrics: {
          GoalMetric(metricName: "repetitions", metricSize: 5),
          GoalMetric(metricName: "weight", metricSize: 180, metricScale: "kg")
        })
  ];
  List<TrainingRegiment>? regiments;
  bool firstTime = false;

  Future<void> setFirstTimeUsing(bool val) async {
    firstTime = val;
  }

  bool isFirstTimeUsing() {
    return firstTime;
  }
}
