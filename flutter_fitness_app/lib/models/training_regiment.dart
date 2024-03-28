import 'package:flutter_fitness_app/models/training_types.dart';
import 'package:flutter_fitness_app/models/training_session.dart';

class TrainingRegiment {
  // TODO make this able to be set only one time
  String? id;
  String? name;
  String? notes;
  TrainingType? trainingType;
  List<TrainingSession>? schedule = [];
  int? cycleDurationInDays = 0;

  TrainingRegiment(
      {this.name,
      this.notes,
      this.trainingType,
      this.schedule,
      this.cycleDurationInDays});
}
