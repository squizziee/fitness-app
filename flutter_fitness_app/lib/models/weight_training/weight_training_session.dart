import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/training_session.dart';
import 'package:flutter_fitness_app/models/weight_training/weight_training_exercise.dart';

class WeightTrainingSession extends TrainingSession {
  int getTotalSetCount() {
    int count = 0;
    for (var e in exercises) {
      count += (e as WeightTrainingExercise).sets.length;
    }
    return count;
  }

  @override
  String getGeneralMetricText() {
    return "${getTotalSetCount()} sets";
  }
}
