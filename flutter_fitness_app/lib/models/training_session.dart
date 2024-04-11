import 'package:flutter_fitness_app/models/exercise.dart';

abstract class TrainingSession {
  String id = '';
  String name = 'New Training Session';
  List<Exercise> exercises = [];
  String notes = '';
  int dayInSchedule = 0;

  @override
  int get hashCode => exercises.hashCode >> dayInSchedule;

  String getGeneralMetricText() {
    return 'undefined metric';
  }
}
