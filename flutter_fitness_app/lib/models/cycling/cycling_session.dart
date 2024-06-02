import 'package:flutter_fitness_app/models/cycling/cycling_exercise.dart';
import 'package:flutter_fitness_app/models/base/training_session.dart';

class CyclingSession extends TrainingSession {
  CyclingSession(
      {required super.id,
      required super.name,
      required super.notes,
      required super.exercises,
      required super.dayInSchedule});

  double getTotalDistance() {
    double total = 0;
    for (var e in exercises) {
      total += (e as CyclingExercise).distanceInMeters!;
    }
    return total;
  }

  @override
  String getGeneralMetricText() {
    return "${getTotalDistance()} km";
  }
}
