import 'package:flutter_fitness_app/models/running/running_exercise.dart';
import 'package:flutter_fitness_app/models/training_session.dart';

class RunningSession extends TrainingSession {
  double getTotalDistance() {
    double total = 0;
    for (var e in exercises) {
      total += (e as RunningExercise).distanceInKilometers!;
    }
    return total;
  }

  @override
  String getGeneralMetricText() {
    return "${getTotalDistance()} km";
  }
}
