import 'package:flutter_fitness_app/models/base/exercise.dart';
import 'package:flutter_fitness_app/models/running/running_exercise_type.dart';

class RunningExercise extends Exercise {
  RunningExerciseType? exerciseType;
  double? distanceInMeters;
  int? heartbeatCeiling;
  Duration? time;

  RunningExercise(
      {required super.notes,
      required this.distanceInMeters,
      required this.exerciseType,
      this.heartbeatCeiling});

  @override
  String getExerciseTypeName() {
    return exerciseType == null ? "" : exerciseType!.name;
  }
}
