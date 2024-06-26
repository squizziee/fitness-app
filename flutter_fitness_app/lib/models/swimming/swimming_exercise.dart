import 'package:flutter_fitness_app/models/base/exercise.dart';
import 'package:flutter_fitness_app/models/swimming/swimming_exercise_type.dart';
import 'package:flutter_fitness_app/models/swimming/swimming_set.dart';

class SwimmingExercise extends Exercise {
  SwimmingExerciseType? exerciseType;
  List<SwimmingSet> sets = [];

  SwimmingExercise(
      {required super.notes, required this.sets, required this.exerciseType});

  @override
  String getExerciseTypeName() {
    return exerciseType == null ? "" : exerciseType!.name;
  }
}
