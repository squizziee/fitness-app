import 'package:flutter_fitness_app/models/training_types.dart';
import 'package:flutter_fitness_app/models/training_session.dart';

class TrainingRegiment {
  dynamic id;
  String? name = "";
  String? notes = "";
  TrainingType? trainingType;
  List<TrainingSession>? schedule = [];
  List<int>? notificationIdList = [];
  DateTime? launchTime;

  DateTime? startDate;
  int dayOfPause = -1;
  int? cycleDurationInDays = 0;

  TrainingRegiment(
      {this.name,
      this.id,
      this.notes,
      this.trainingType,
      this.schedule,
      this.notificationIdList,
      this.startDate,
      this.cycleDurationInDays,
      required this.dayOfPause});

  int getCurrentDay() {
    if (startDate == null) {
      return -1;
    }
    if (isPaused()) {
      return dayOfPause;
    }
    if (DateTime.now().difference(startDate!).inDays > cycleDurationInDays!) {
      startDate = null;
      dayOfPause = -1;
      return -1;
    }
    return DateTime.now().difference(startDate!).inDays % cycleDurationInDays!;
  }

  bool isPaused() {
    return dayOfPause != -1;
  }
}
