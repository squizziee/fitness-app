import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/exercise_type.dart';
import 'package:flutter_fitness_app/models/weight_training/weight_training_exercise.dart';
import 'package:flutter_fitness_app/repos/current_exercise.dart';
import 'package:flutter_fitness_app/repos/current_training_session.dart';
import 'package:flutter_fitness_app/services/exercise_service.dart';
import 'package:provider/provider.dart';

class WeightExerciseService extends ExerciseService {
  void setExerciseType(BuildContext context, WeightExerciseType exerciseType) {
    var exercise = (Provider.of<CurrentExercise>(context, listen: false)
        .exercise! as WeightTrainingExercise);

    exercise.exerciseType = exerciseType;
    Provider.of<CurrentExercise>(context, listen: false).exercise = exercise;
  }

  void addSet(BuildContext context, String notes, int repetitions,
      double weightInKilograms, int setIndex) {
    assert(repetitions > 0);
    assert(setIndex >= 0);
    assert(weightInKilograms >= 0);

    var exercise = (Provider.of<CurrentExercise>(context, listen: false)
        .exercise! as WeightTrainingExercise);

    exercise.sets.add(WeightTrainingSet(
        weightInKilograms: weightInKilograms,
        repetitions: repetitions,
        notes: notes,
        setIndex: setIndex));

    Provider.of<CurrentExercise>(context, listen: false).exercise = exercise;
  }

  void updateSetWeight(
      BuildContext context, int setIndex, double weightInKilograms) {
    var exercise = (Provider.of<CurrentExercise>(context, listen: false)
        .exercise! as WeightTrainingExercise);

    assert(weightInKilograms >= 0);
    exercise.sets[setIndex].weightInKilograms = weightInKilograms;

    Provider.of<CurrentExercise>(context, listen: false).exercise = exercise;
  }

  void updateSetRepetitions(
      BuildContext context, int setIndex, int repetitions) {
    var exercise = (Provider.of<CurrentExercise>(context, listen: false)
        .exercise! as WeightTrainingExercise);

    assert(repetitions > 0);
    exercise.sets[setIndex].repetitions = repetitions;

    Provider.of<CurrentExercise>(context, listen: false).exercise = exercise;
  }

  void updateSetNotes(BuildContext context, int setIndex, String notes) {
    var exercise = (Provider.of<CurrentExercise>(context, listen: false)
        .exercise! as WeightTrainingExercise);

    exercise.sets[setIndex].notes = notes;

    Provider.of<CurrentExercise>(context, listen: false).exercise = exercise;
  }

  void removeLastSet(BuildContext context) {
    var exercise = (Provider.of<CurrentExercise>(context, listen: false)
        .exercise! as WeightTrainingExercise);
    exercise.sets.remove(exercise.sets.last);
    Provider.of<CurrentExercise>(context, listen: false).exercise = exercise;
  }

  @override
  void createAndOpenEmptyExercise(BuildContext context) {
    var session =
        Provider.of<CurrentTrainingSession>(context, listen: false).session;
    var exercise = WeightTrainingExercise();
    session!.exercises.add(exercise);
    Provider.of<CurrentExercise>(context, listen: false).exercise = exercise;
    Provider.of<CurrentTrainingSession>(context, listen: false).session =
        session;
  }

  @override
  bool isExerciseEmpty(BuildContext context) {
    var exercise = (Provider.of<CurrentExercise>(context, listen: false)
        .exercise! as WeightTrainingExercise);
    return (exercise.exerciseType == null);
  }
}
