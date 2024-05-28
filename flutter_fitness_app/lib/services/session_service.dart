import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/exercise.dart';
import 'package:flutter_fitness_app/models/training_session.dart';
import 'package:flutter_fitness_app/models/weight_training/weight_training_exercise.dart';
import 'package:flutter_fitness_app/models/weight_training/weight_training_session.dart';
import 'package:flutter_fitness_app/repos/current_training_session.dart';
import 'package:flutter_fitness_app/repos/current_training_regiment.dart';
import 'package:flutter_fitness_app/services/database_service.dart';
import 'package:provider/provider.dart';

class SessionService {
  final DatabaseService _dbService = DatabaseService();

  void openSession(BuildContext context, int dayInSchedule) {
    var regiment =
        Provider.of<CurrentTrainingRegiment>(context, listen: false).regiment;
    Provider.of<CurrentTrainingSession>(context, listen: false).session =
        regiment!.schedule![dayInSchedule];
  }

  int getOpenedSessionIndex(BuildContext context) {
    return Provider.of<CurrentTrainingSession>(context, listen: false)
        .session!
        .dayInSchedule;
  }

  void openSessionByInstance(BuildContext context, TrainingSession session) {
    Provider.of<CurrentTrainingSession>(context, listen: false).session =
        session;
  }

  Future<void> copySession(
      BuildContext context, TrainingSession session, int destIndex) async {
    var destSession =
        Provider.of<CurrentTrainingRegiment>(context, listen: false)
            .regiment!
            .schedule![destIndex];
    if (destSession is WeightTrainingSession &&
        session is WeightTrainingSession) {
      destSession.exercises.clear();
      destSession.name = session.name;
      destSession.notes = session.notes;
      for (var exercise in session.exercises) {
        var _exercise = exercise as WeightTrainingExercise;
        destSession.exercises.add(_exercise);
      }
    }
    await _saveSessionToDatabase(context);
  }

  void updateName(BuildContext context, String newName) {
    Provider.of<CurrentTrainingSession>(context, listen: false).session!.name =
        newName;
    _saveSessionToDatabase(context);
  }

  void updateNotes(BuildContext context, String newNotes) {
    Provider.of<CurrentTrainingSession>(context, listen: false).session!.name =
        newNotes;
    _saveSessionToDatabase(context);
  }

  void removeExercise(BuildContext context, Exercise exercise) {
    Provider.of<CurrentTrainingSession>(context, listen: false)
        .session!
        .exercises
        .remove(exercise);
    _saveSessionToDatabase(context);
  }

  Future<void> _saveSessionToDatabase(context) async {
    var regiment =
        Provider.of<CurrentTrainingRegiment>(context, listen: false).regiment!;
    var session =
        Provider.of<CurrentTrainingSession>(context, listen: false).session!;
    await _dbService.postSession(session);
    await _dbService.postRegiment(regiment);
  }
}
