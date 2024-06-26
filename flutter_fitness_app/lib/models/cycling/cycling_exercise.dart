import 'package:flutter_fitness_app/models/cycling/cycling_exercise_type.dart';
import 'package:flutter_fitness_app/models/base/exercise.dart';

class CyclingExercise extends Exercise {
  CyclingExerciseType? exerciseType;
  int? cadence;
  double? distanceInMeters;
  int? heartbeatCeiling;
  Duration? time;

  CyclingExercise(
      {required super.notes,
      required this.exerciseType,
      required this.distanceInMeters,
      required this.time,
      this.cadence,
      this.heartbeatCeiling});

  @override
  String getExerciseTypeName() {
    return exerciseType == null ? "" : exerciseType!.name;
  }
}
