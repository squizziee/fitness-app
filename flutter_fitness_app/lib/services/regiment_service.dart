import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/weight_training/weight_training_session.dart';
import 'package:flutter_fitness_app/repos/current_training_regiment.dart';
import 'package:flutter_fitness_app/models/training_regiment.dart';
import 'package:flutter_fitness_app/models/training_session.dart';
import 'package:flutter_fitness_app/models/training_types.dart';
import 'package:provider/provider.dart';

class RegimentService {
  void createAndOpenEmptyRegiment(BuildContext context) {
    Provider.of<CurrentTrainingRegiment>(context, listen: false).regiment =
        TrainingRegiment();
  }

  void setName(BuildContext context, String name) {
    Provider.of<CurrentTrainingRegiment>(context, listen: false)
        .regiment!
        .name = name;
  }

  void setNotes(BuildContext context, String notes) {
    Provider.of<CurrentTrainingRegiment>(context, listen: false)
        .regiment!
        .notes = notes;
  }

  void setTrainingType(BuildContext context, TrainingType trainingType) {
    Provider.of<CurrentTrainingRegiment>(context, listen: false)
        .regiment!
        .trainingType = trainingType;
  }

  void setCycleDurationInDays(BuildContext context, int cycleDurationInDays) {
    Provider.of<CurrentTrainingRegiment>(context, listen: false)
        .regiment!
        .cycleDurationInDays = cycleDurationInDays;
    _setDefaultSchedule(context, cycleDurationInDays);
  }

  void openRegiment(BuildContext context, TrainingRegiment regiment) {
    Provider.of<CurrentTrainingRegiment>(context, listen: false).regiment =
        regiment;
  }

  void _setDefaultSchedule(BuildContext context, int cycleDurationInDays) {
    var trainingType =
        Provider.of<CurrentTrainingRegiment>(context, listen: false)
            .regiment!
            .trainingType;

    var schedule = List<TrainingSession>.empty(growable: true);
    for (int i = 0; i < cycleDurationInDays; i++) {
      TrainingSession? session;
      if (trainingType is WeightTraining) {
        session = WeightTrainingSession();
      }
      session!.dayInSchedule = i;
      schedule.add(session);
    }

    Provider.of<CurrentTrainingRegiment>(context, listen: false)
        .regiment!
        .schedule = schedule;
  }

  void startRegiment(BuildContext context) {
    Provider.of<CurrentTrainingRegiment>(context).regiment!.startDate =
        DateTime.now();
  }

  void stopRegiment(BuildContext context) {
    Provider.of<CurrentTrainingRegiment>(context).regiment!.startDate = null;
  }

  void pauseRegiment(BuildContext context) {
    var regiment = Provider.of<CurrentTrainingRegiment>(context).regiment!;
    regiment.dayOfPause = regiment.getCurrentDay();
  }

  void resumeRegiment(BuildContext context) {
    var regiment = Provider.of<CurrentTrainingRegiment>(context).regiment!;
    regiment.startDate =
        DateTime.now().subtract(Duration(days: regiment.dayOfPause));
    regiment.dayOfPause = -1;
  }

  void saveRegimentToDatabase() {
    // next time...
  }
}
