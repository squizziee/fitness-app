// ignore_for_file: unused_field

class Goal {
  DateTime? deadline;
  String? exerciseName;
  Set<GoalMetric>? metrics;

  Goal({this.deadline, this.exerciseName, this.metrics});

  @override
  operator ==(other) {
    return other is Goal &&
        deadline == other.deadline &&
        //metrics!.difference(other.metrics!).isEmpty &&
        exerciseName == other.exerciseName;
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
}
