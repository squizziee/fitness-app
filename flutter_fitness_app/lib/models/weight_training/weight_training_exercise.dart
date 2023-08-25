import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/exercise.dart';

class WeightTrainingExercise extends Exercise {
  List<WeightTrainingSet> sets = [];
}

class WeightTrainingSet {
  String notes = '';
  int repetitions = 0;
  int setIndex = 0;
  int weightInKilograms = 0;

  Widget getWidget() {
    return Container(
      child: Column(children: [
        Text(notes),
        Text(repetitions.toString()),
        Text(setIndex.toString()),
        Text(weightInKilograms.toString())
      ]),
    );
  }
}
