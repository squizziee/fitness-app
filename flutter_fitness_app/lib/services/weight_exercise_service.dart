import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/weight_training/weight_exercise_type.dart';
import 'package:flutter_fitness_app/models/weight_training/weight_training_exercise.dart';
import 'package:flutter_fitness_app/models/weight_training/weight_training_set.dart';
import 'package:flutter_fitness_app/repos/current_exercise.dart';
import 'package:flutter_fitness_app/repos/current_training_session.dart';
import 'package:flutter_fitness_app/services/database_service.dart';
import 'package:flutter_fitness_app/services/exercise_service.dart';
import 'package:provider/provider.dart';

class WeightExerciseService extends ExerciseService {
  final DatabaseService _dbService = DatabaseService();

  Future<void> setExerciseType(
      BuildContext context, WeightExerciseType? exerciseType) async {
    var exercise = (Provider.of<CurrentExercise>(context, listen: false)
        .exercise! as WeightTrainingExercise);

    if (exercise.exerciseType != null && exerciseType == null) return;

    exercise.exerciseType = exerciseType;
    Provider.of<CurrentExercise>(context, listen: false).exercise = exercise;
    await _saveSessionToDatabase(context);
  }

  Future<void> addSet(BuildContext context, String notes, int repetitions,
      double weightInKilograms) async {
    var exercise = (Provider.of<CurrentExercise>(context, listen: false)
        .exercise! as WeightTrainingExercise);

    exercise.sets.add(WeightTrainingSet(
        weightInKilograms: weightInKilograms,
        repetitions: repetitions,
        notes: notes,
        setIndex: exercise.sets.length));

    Provider.of<CurrentExercise>(context, listen: false).exercise = exercise;
    await _saveSessionToDatabase(context);
  }

  void _renumerateSets(List<WeightTrainingSet> sets) {
    for (int i = 0; i < sets.length; i++) {
      sets[i].setIndex = i;
    }
  }

  Future<void> reinsertSet(
      BuildContext context, int oldIndex, int newIndex) async {
    var exercise = Provider.of<CurrentExercise>(context, listen: false).exercise
        as WeightTrainingExercise;

    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    var set = exercise.sets.removeAt(oldIndex);
    exercise.sets.insert(newIndex, set);

    _renumerateSets(exercise.sets);

    await _saveSessionToDatabase(context);
  }

  Future<void> updateSetWeight(
      BuildContext context, int setIndex, double weightInKilograms) async {
    var exercise = (Provider.of<CurrentExercise>(context, listen: false)
        .exercise! as WeightTrainingExercise);

    exercise.sets[setIndex].weightInKilograms = weightInKilograms;

    Provider.of<CurrentExercise>(context, listen: false).exercise = exercise;
    await _saveSessionToDatabase(context);
  }

  Future<void> updateSetRepetitions(
      BuildContext context, int setIndex, int repetitions) async {
    var exercise = (Provider.of<CurrentExercise>(context, listen: false)
        .exercise! as WeightTrainingExercise);

    exercise.sets[setIndex].repetitions = repetitions;

    Provider.of<CurrentExercise>(context, listen: false).exercise = exercise;
    await _saveSessionToDatabase(context);
  }

  Future<void> updateSetNotes(
      BuildContext context, int setIndex, String notes) async {
    var exercise = (Provider.of<CurrentExercise>(context, listen: false)
        .exercise! as WeightTrainingExercise);

    exercise.sets[setIndex].notes = notes;

    Provider.of<CurrentExercise>(context, listen: false).exercise = exercise;
    await _saveSessionToDatabase(context);
  }

  Future<void> removeLastSet(BuildContext context) async {
    var exercise = (Provider.of<CurrentExercise>(context, listen: false)
        .exercise! as WeightTrainingExercise);
    exercise.sets.remove(exercise.sets.last);
    Provider.of<CurrentExercise>(context, listen: false).exercise = exercise;
    await _saveSessionToDatabase(context);
  }

  Future<void> removeSet(BuildContext context, int setIndex) async {
    var sets = (Provider.of<CurrentExercise>(context, listen: false).exercise!
            as WeightTrainingExercise)
        .sets;

    sets.removeAt(setIndex);

    _renumerateSets(sets);

    await _saveSessionToDatabase(context);
  }

  @override
  void createAndOpenEmptyExercise(BuildContext context) {
    var session =
        Provider.of<CurrentTrainingSession>(context, listen: false).session;
    var exercise = WeightTrainingExercise(sets: [], notes: '');
    Provider.of<CurrentExercise>(context, listen: false).exercise = exercise;
    Provider.of<CurrentTrainingSession>(context, listen: false).session =
        session;
    //_saveSessionToDatabase(context);
  }

  @override
  bool isExerciseEmpty(BuildContext context) {
    var exercise = (Provider.of<CurrentExercise>(context, listen: false)
        .exercise! as WeightTrainingExercise);
    return (exercise.exerciseType == null);
  }

  Future<void> _saveSessionToDatabase(context) async {
    var exercise = (Provider.of<CurrentExercise>(context, listen: false)
        .exercise! as WeightTrainingExercise);
    var session =
        Provider.of<CurrentTrainingSession>(context, listen: false).session!;

    if (exercise.exerciseType != null) {
      if (!session.exercises.contains(exercise)) {
        session.exercises.add(exercise);
      }
      await _dbService.postSession(session);
    }
  }
}
