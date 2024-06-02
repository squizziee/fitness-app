import 'package:flutter_fitness_app/models/base/exercise.dart';
import 'package:flutter_fitness_app/models/rowing/rowing_exercise_type.dart';

class RowingExercise extends Exercise {
  RowingExerciseType? exerciseType;
  double? distanceInMeters;
  int? heartbeatCeiling;
  Duration? time;

  RowingExercise(
      {required super.notes,
      required this.exerciseType,
      required this.distanceInMeters,
      required this.time,
      this.heartbeatCeiling});

  @override
  String getExerciseTypeName() {
    return exerciseType == null ? "" : exerciseType!.name;
  }
}
