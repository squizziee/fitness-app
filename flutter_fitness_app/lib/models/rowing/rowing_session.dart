import 'package:flutter_fitness_app/models/rowing/rowing_exercise.dart';
import 'package:flutter_fitness_app/models/training_session.dart';

class RowingSession extends TrainingSession {
  double getTotalDistance() {
    double total = 0;
    for (var e in exercises) {
      total += (e as RowingExercise).distanceInKilometers!;
    }
    return total;
  }

  @override
  String getGeneralMetricText() {
    return "${getTotalDistance()} km";
  }
}