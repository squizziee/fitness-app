import 'package:flutter_fitness_app/models/training_session.dart';
import 'package:flutter_fitness_app/models/weight_training/weight_training_exercise.dart';

class WeightTrainingSession extends TrainingSession {
  WeightTrainingSession(
      {required super.id,
      required super.name,
      required super.notes,
      required super.exercises,
      required super.dayInSchedule});

  int getTotalSetCount() {
    int count = 0;
    for (var e in exercises) {
      count += (e as WeightTrainingExercise).sets.length;
    }
    return count;
  }

  @override
  String getGeneralMetricText() {
    var setCount = getTotalSetCount();
    return "$setCount ${setCount % 10 == 1 ? "set" : "sets"}";
  }

  @override
  List<String> getGeneralCategories() {
    Map<String, int> result = {};

    for (var exercise in exercises) {
      var bodyPart =
          (exercise as WeightTrainingExercise).exerciseType!.bodyPart;

      if (result[bodyPart] == null) {
        result[bodyPart] = 1;
      } else {
        result[bodyPart] = result[bodyPart]! + 1;
      }
    }
    var temp = result.entries.toList();
    temp.sort(((a, b) => a.value.compareTo(b.value)));
    return Map.fromEntries(temp).keys.toList().reversed.toList();
  }
}
