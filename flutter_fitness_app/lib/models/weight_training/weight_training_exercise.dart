import 'package:flutter_fitness_app/models/exercise.dart';
import 'package:flutter_fitness_app/models/exercise_type.dart';

class WeightTrainingExercise extends Exercise {
  WeightExerciseType? exerciseType;
  List<WeightTrainingSet> sets = [];

  @override
  String getExerciseTypeName() {
    return exerciseType == null ? "" : exerciseType!.name;
  }
}

class WeightTrainingSet {
  String notes = '';
  int repetitions = 0;
  int setIndex = 0;
  double weightInKilograms = 0;

  WeightTrainingSet(
      {required this.weightInKilograms,
      required this.repetitions,
      required this.notes,
      required this.setIndex});
}
