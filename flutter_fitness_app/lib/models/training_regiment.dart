import 'package:flutter_fitness_app/models/training_types.dart';
import 'package:flutter_fitness_app/models/training_session.dart';
import 'package:string_validator/string_validator.dart';

class TrainingRegiment {
  String _id = '';
  String _name = '';
  String _notes = '';
  TrainingType? _trainingType;
  // ignore: prefer_final_fields
  List<TrainingSession> _schedule = [];
  int _cycleDurationInDays = 0;

  void setId(String id) {
    _id = id;
  }

  String getId() {
    return _id;
  }

  void setName(String name) {
    if (!isAlphanumeric(name)) {
      throw Exception('Regiment name should only contain letters and numbers');
    }
    _name = name;
  }

  String getName() {
    return _name;
  }

  void setNotes(String notes) {
    _notes = notes;
  }

  String getNotes() {
    return _notes;
  }

  void setTrainingType(TrainingType trainingType) {
    _trainingType = trainingType;
  }

  TrainingType? getTrainingType() {
    return _trainingType;
  }

  void addToSchedule(TrainingSession session) {
    _schedule.add(session);
  }

  void removeFromSchedule(TrainingSession session) {
    _schedule.remove(session);
  }

  void setCycleDurationInDays(int cycleDurationInDays) {
    _cycleDurationInDays = cycleDurationInDays;
  }

  int getCycleDurationInDays() {
    return _cycleDurationInDays;
  }
}
