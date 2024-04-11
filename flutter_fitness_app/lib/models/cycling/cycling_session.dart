import 'package:flutter_fitness_app/models/cycling/cycling_exercise.dart';
import 'package:flutter_fitness_app/models/training_session.dart';

class CyclingSession extends TrainingSession {
  double getTotalDistance() {
    double total = 0;
    for (var e in exercises) {
      total += (e as CyclingExercise).distanceInKilometers!;
    }
    return total;
  }

  @override
  String getGeneralMetricText() {
    return "${getTotalDistance()} km";
  }
}
