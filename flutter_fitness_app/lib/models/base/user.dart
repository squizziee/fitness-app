// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/base/goal.dart';
import 'package:flutter_fitness_app/models/base/training_regiment.dart';

class AppUser extends ChangeNotifier {
  String? userUID;
  List<Goal>? goals = [];
  List<TrainingRegiment>? regiments = [];
}
