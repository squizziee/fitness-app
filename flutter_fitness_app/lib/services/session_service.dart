import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/exercise.dart';
import 'package:flutter_fitness_app/repos/current_training_session.dart';
import 'package:flutter_fitness_app/repos/current_training_regiment.dart';
import 'package:provider/provider.dart';

class SessionService {
  void openSession(BuildContext context, int dayInSchedule) {
    var regiment =
        Provider.of<CurrentTrainingRegiment>(context, listen: false).regiment;
    Provider.of<CurrentTrainingSession>(context, listen: false).session =
        regiment!.schedule![dayInSchedule];
  }

  void updateName(BuildContext context, String newName) {
    Provider.of<CurrentTrainingSession>(context, listen: false).session!.name =
        newName;
  }

  void updateNotes(BuildContext context, String newNotes) {
    Provider.of<CurrentTrainingSession>(context, listen: false).session!.name =
        newNotes;
  }

  void removeExercise(BuildContext context, Exercise exercise) {
    Provider.of<CurrentTrainingSession>(context, listen: false)
        .session!
        .exercises
        .remove(exercise);
  }
}
