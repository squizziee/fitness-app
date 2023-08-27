import 'package:flutter_fitness_app/models/exercise.dart';

class TrainingSession {
  String _id = '';
  String _name = 'default';
  List<Exercise> _exercises = [];
  String _notes = '';
  int _dayInSchedule = 0;

  String get id => _id;
  set id(String value) => _id = value;

  String get name => _name;
  set name(String value) => _name = value;

  List<Exercise> get exercises => _exercises;
  set exercises(List<Exercise> value) => _exercises = value;

  String get notes => _notes;
  set notes(String value) => _notes = value;

  int get dayInSchedule => _dayInSchedule;
  set dayInSchedule(int value) => _dayInSchedule = value;
}
