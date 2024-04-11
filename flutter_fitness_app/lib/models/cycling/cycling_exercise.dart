import 'package:flutter_fitness_app/models/cycling/cycling_exercise_type.dart';
import 'package:flutter_fitness_app/models/exercise.dart';

class CyclingExercise extends Exercise {
  CyclingExerciseType? exerciseType;
  int? cadence;
  double? distanceInKilometers;
  int? heartbeatCeiling;
  Duration? time;

  @override
  String getExerciseTypeName() {
    return exerciseType == null ? "" : exerciseType!.name;
  }
}