import 'package:flutter/widgets.dart';
import 'package:flutter_fitness_app/models/exercise.dart';

class TrainingSession {
  String id = '';
  String name = 'default';
  List<Exercise> exercises = [];
  String notes = '';
  int dayInSchedule = 0;

  Widget getGeneralMetricText() {
    return const Text('undefined metric');
  }
}
