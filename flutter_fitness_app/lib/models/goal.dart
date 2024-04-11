// ignore_for_file: unused_field

class Goal {
  DateTime? deadline;
  String? exerciseName;
  Set<GoalMetric>? metrics;

  Goal({this.deadline, this.exerciseName, this.metrics});
}

class GoalMetric {
  String? metricName;
  double? metricSize;
  String? metricScale = "";

  GoalMetric({this.metricName, this.metricSize, this.metricScale});
}
