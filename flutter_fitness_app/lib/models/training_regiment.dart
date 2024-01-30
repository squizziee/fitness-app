import 'package:flutter_fitness_app/models/training_types.dart';
import 'package:flutter_fitness_app/models/training_session.dart';
import 'package:string_validator/string_validator.dart';

class TrainingRegiment {
  String id = '';
  String name = '';
  String notes = '';
  TrainingType? trainingType;
  // ignore: prefer_final_fields
  List<TrainingSession> schedule = [];
  int cycleDurationInDays = 0;
}
