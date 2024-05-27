import 'package:flutter_fitness_app/models/combat_training/combat_training_exercise_type.dart';
import 'package:flutter_fitness_app/models/exercise.dart';

class CombatTrainingExercise extends Exercise {
  CombatTrainingExerciseType? exerciseType;
  int? heartbeatCeiling;
  Duration? time;

  CombatTrainingExercise(
      {required super.notes,
      required this.exerciseType,
      required this.time,
      this.heartbeatCeiling});

  @override
  String getExerciseTypeName() {
    return exerciseType == null ? "" : exerciseType!.name;
  }
}
