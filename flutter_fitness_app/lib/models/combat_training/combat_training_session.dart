import 'package:flutter_fitness_app/models/combat_training/combat_training_exercise.dart';
import 'package:flutter_fitness_app/models/training_session.dart';

class CombatTrainingSession extends TrainingSession {
  int getWorkoutDurationInMins() {
    int total = 0;
    for (var e in exercises) {
      total += (e as CombatTrainingExercise).time!.inMinutes;
    }
    return total;
  }

  @override
  String getGeneralMetricText() {
    return "${getWorkoutDurationInMins()} min";
  }
}
