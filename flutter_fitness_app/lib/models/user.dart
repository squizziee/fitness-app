// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/goal.dart';
import 'package:flutter_fitness_app/models/training_regiment.dart';

class AppUser extends ChangeNotifier {
  String? _userUID;
  List<Goal>? _goals;
  List<TrainingRegiment>? _regiments;
  bool _firstTime = false;

  Future<void> setFirstTimeUsing(bool val) async {
    _firstTime = val;
  }

  bool isFirstTimeUsing() {
    return _firstTime;
  }
}
