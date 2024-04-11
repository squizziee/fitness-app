import 'package:flutter_fitness_app/models/exercise.dart';
import 'package:flutter_fitness_app/models/weight_training/weight_exercise_type.dart';
import 'package:flutter_fitness_app/models/weight_training/weight_training_set.dart';

class WeightTrainingExercise extends Exercise {
  WeightExerciseType? exerciseType;
  List<WeightTrainingSet> sets = [];

  @override
  String getExerciseTypeName() {
    return exerciseType == null ? "" : exerciseType!.name;
  }
}
