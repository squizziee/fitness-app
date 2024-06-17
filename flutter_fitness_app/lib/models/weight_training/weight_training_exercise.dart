import 'package:flutter_fitness_app/models/base/exercise.dart';
import 'package:flutter_fitness_app/models/weight_training/weight_exercise_type.dart';
import 'package:flutter_fitness_app/models/weight_training/weight_training_set.dart';

class WeightTrainingExercise extends Exercise {
  WeightExerciseType? exerciseType;
  List<WeightTrainingSet> sets = [];

  WeightTrainingExercise({required this.sets, this.exerciseType, super.notes});

  @override
  String getExerciseTypeName() {
    return exerciseType == null ? "" : exerciseType!.name;
  }

  @override
  String? getImageUrl() {
    if (exerciseType == null) return null;
    return exerciseType!.iconURL;
  }

  @override
  String getMainMetricText() {
    return "${sets.length} sets";
  }

  @override
  String getSecondaryMetricText() {
    if (exerciseType == null) return "";
    return exerciseType!.bodyPart;
  }
}
