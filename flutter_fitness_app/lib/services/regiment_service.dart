import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/combat_training/combat_training_session.dart';
import 'package:flutter_fitness_app/models/cycling/cycling_session.dart';
import 'package:flutter_fitness_app/models/rowing/rowing_session.dart';
import 'package:flutter_fitness_app/models/running/running_session.dart';
import 'package:flutter_fitness_app/models/swimming/swimming_session.dart';
import 'package:flutter_fitness_app/models/user.dart';
import 'package:flutter_fitness_app/models/weight_training/weight_training_session.dart';
import 'package:flutter_fitness_app/repos/current_training_regiment.dart';
import 'package:flutter_fitness_app/models/training_regiment.dart';
import 'package:flutter_fitness_app/models/training_session.dart';
import 'package:flutter_fitness_app/models/training_types.dart';
import 'package:flutter_fitness_app/services/database_service.dart';
import 'package:provider/provider.dart';

class RegimentService {
  final DatabaseService _dbService = DatabaseService();

  void createAndOpenEmptyRegiment(BuildContext context) {
    var newRegiment = TrainingRegiment();
    Provider.of<CurrentTrainingRegiment>(context, listen: false).regiment =
        newRegiment;
    Provider.of<AppUser>(context, listen: false).regiments!.add(newRegiment);
    _saveRegimentToDatabase(context);
  }

  void setName(BuildContext context, String name) {
    Provider.of<CurrentTrainingRegiment>(context, listen: false)
        .regiment!
        .name = name;
    _saveRegimentToDatabase(context);
  }

  void setNotes(BuildContext context, String notes) {
    Provider.of<CurrentTrainingRegiment>(context, listen: false)
        .regiment!
        .notes = notes;
    _saveRegimentToDatabase(context);
  }

  void setTrainingType(BuildContext context, TrainingType trainingType) {
    Provider.of<CurrentTrainingRegiment>(context, listen: false)
        .regiment!
        .trainingType = trainingType;
    _saveRegimentToDatabase(context);
  }

  void setCycleDurationInDays(BuildContext context, int cycleDurationInDays) {
    Provider.of<CurrentTrainingRegiment>(context, listen: false)
        .regiment!
        .cycleDurationInDays = cycleDurationInDays;
    _setDefaultSchedule(context, cycleDurationInDays);
    _saveRegimentToDatabase(context);
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
        session = WeightTrainingSession(
            id: null, name: '', notes: '', exercises: [], dayInSchedule: 0);
      } else if (trainingType is Swimming) {
        session = SwimmingSession(
            id: null, name: '', notes: '', exercises: [], dayInSchedule: 0);
      } else if (trainingType is Cycling) {
        session = CyclingSession(
            id: null, name: '', notes: '', exercises: [], dayInSchedule: 0);
      } else if (trainingType is Running) {
        session = RunningSession(
            id: null, name: '', notes: '', exercises: [], dayInSchedule: 0);
      } else if (trainingType is Rowing) {
        session = RowingSession(
            id: null, name: '', notes: '', exercises: [], dayInSchedule: 0);
      } else if (trainingType is CombatTraining) {
        session = CombatTrainingSession(
            id: null, name: '', notes: '', exercises: [], dayInSchedule: 0);
      }
      session!.dayInSchedule = i;
      schedule.add(session);
      _dbService.postSession(session);
    }

    Provider.of<CurrentTrainingRegiment>(context, listen: false)
        .regiment!
        .schedule = schedule;
  }

  void startRegiment(BuildContext context) {
    Provider.of<CurrentTrainingRegiment>(context, listen: false)
        .regiment!
        .startDate = DateTime.now();
    _saveRegimentToDatabase(context);
  }

  void stopRegiment(BuildContext context) {
    Provider.of<CurrentTrainingRegiment>(context, listen: false)
        .regiment!
        .startDate = null;
    _saveRegimentToDatabase(context);
  }

  void pauseRegiment(BuildContext context) {
    var regiment =
        Provider.of<CurrentTrainingRegiment>(context, listen: false).regiment!;
    regiment.dayOfPause = regiment.getCurrentDay();
    _saveRegimentToDatabase(context);
  }

  void resumeRegiment(BuildContext context) {
    var regiment =
        Provider.of<CurrentTrainingRegiment>(context, listen: false).regiment!;
    regiment.startDate =
        DateTime.now().subtract(Duration(days: regiment.dayOfPause!));
    regiment.dayOfPause = -1;
    _saveRegimentToDatabase(context);
  }

  // TODO save AppUser too to update regiment references
  void _saveRegimentToDatabase(BuildContext context) async {
    var regiment =
        Provider.of<CurrentTrainingRegiment>(context, listen: false).regiment!;
    var user = Provider.of<AppUser>(context, listen: false);
    if (regiment.trainingType != null && regiment.schedule != null) {
      await _dbService.postAppUser(user);
      await _dbService.postRegiment(regiment);
    }
  }
}
