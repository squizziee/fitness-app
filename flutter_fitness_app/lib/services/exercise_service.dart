import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/repos/current_exercise.dart';
import 'package:flutter_fitness_app/repos/current_training_session.dart';
import 'package:provider/provider.dart';

abstract class ExerciseService {
  void openExercise(BuildContext context, int exerciseIndex) {
    var session =
        Provider.of<CurrentTrainingSession>(context, listen: false).session;
    Provider.of<CurrentExercise>(context, listen: false).exercise =
        session!.exercises[exerciseIndex];
  }

  void createAndOpenEmptyExercise(BuildContext context);

  bool isExerciseEmpty(BuildContext context);

  void setNotes(BuildContext context, String notes) {
    Provider.of<CurrentExercise>(context, listen: false).exercise!.notes =
        notes;
  }
}
