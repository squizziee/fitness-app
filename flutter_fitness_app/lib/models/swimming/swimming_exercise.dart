import 'package:flutter_fitness_app/models/exercise.dart';
import 'package:flutter_fitness_app/models/swimming/swimming_exercise_type.dart';
import 'package:flutter_fitness_app/models/swimming/swimming_set.dart';

class SwimmingExercise extends Exercise {
  SwimmingExerciseType? exerciseType;
  List<SwimmingSet> sets = [];

  @override
  String getExerciseTypeName() {
    return exerciseType == null ? "" : exerciseType!.name;
  }
}
