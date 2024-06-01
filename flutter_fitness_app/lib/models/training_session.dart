import 'package:flutter_fitness_app/models/exercise.dart';

abstract class TrainingSession {
  dynamic id;
  String name = 'New Training Session';
  List<Exercise> exercises = [];
  String notes = '';
  int dayInSchedule = 0;

  TrainingSession(
      {required this.id,
      required this.name,
      required this.notes,
      required this.exercises,
      required this.dayInSchedule});
  @override
  int get hashCode => exercises.hashCode >> dayInSchedule;

  String getGeneralMetricText() {
    return 'undefined metric';
  }

  List<String> getGeneralCategories() {
    return [];
  }
}
