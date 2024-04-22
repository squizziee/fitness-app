import 'package:flutter_fitness_app/models/swimming/swimming_exercise.dart';
import 'package:flutter_fitness_app/models/training_session.dart';

class SwimmingSession extends TrainingSession {
  SwimmingSession(
      {required super.id,
      required super.name,
      required super.notes,
      required super.exercises,
      required super.dayInSchedule});

  int getTotalSetCount() {
    int count = 0;
    for (var e in exercises) {
      count += (e as SwimmingExercise).sets.length;
    }
    return count;
  }

  double getTotalDistance() {
    double total = 0;
    for (var e in exercises) {
      var sets = (e as SwimmingExercise).sets;
      for (var s in sets) {
        total += s.distanceInMeters!;
      }
    }
    return total;
  }

  @override
  String getGeneralMetricText() {
    return "${getTotalDistance()} km";
  }
}
