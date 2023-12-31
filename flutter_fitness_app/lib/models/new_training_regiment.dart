// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'training_types.dart';

class NewTrainingRegiment extends ChangeNotifier {
  String? _name;
  TrainingType? _trainingType;
  int? _cycleDurationInDays;

  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  void setTrainingType(TrainingType type) {
    _trainingType = type;
    notifyListeners();
  }

  void setCycleDurationInDays(int days) {
    _cycleDurationInDays = days;
    notifyListeners();
  }
}
