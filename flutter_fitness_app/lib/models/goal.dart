// ignore_for_file: unused_field

import 'package:flutter_fitness_app/models/weight_training/weight_exercise_type.dart';

class Goal {
  dynamic id;
  DateTime? deadline;
  WeightExerciseType? exerciseType;
  Set<GoalMetric>? metrics;

  Goal({this.id, this.deadline, this.exerciseType, this.metrics});

  @override
  operator ==(other) {
    return other is Goal &&
        deadline == other.deadline &&
        //metrics!.difference(other.metrics!).isEmpty &&
        exerciseType!.name == other.exerciseType!.name;
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
