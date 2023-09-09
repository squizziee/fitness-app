import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/exercise.dart';

class WeightTrainingExercise extends Exercise {
  List<WeightTrainingSet> sets = [];

  @override
  Widget getExercisePreviewWidgetLayout() {
    return Column(children: [
      Text(exerciseType!.name),
      Text(exerciseType!.bodyPart),
      Text(sets.length.toString()),
    ]);
  }
}

class WeightTrainingSet {
  String notes = '';
  int repetitions = 0;
  int setIndex = 0;
  int weightInKilograms = 0;

  Widget getWidget() {
    return Column(children: [
      Text(notes),
      Text(repetitions.toString()),
      Text(setIndex.toString()),
      Text(weightInKilograms.toString())
    ]);
  }
}
