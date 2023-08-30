import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_fitness_app/models/exercise_type.dart';

void fillDatabaseWithExercises(String json) {
  final parsedJson = jsonDecode(json);
  var exerciseCollection = FirebaseFirestore.instance
      .collection('strength_exercises')
      .withConverter(
          fromFirestore: ExerciseType.fromFirestore,
          toFirestore: (ExerciseType e, options) => e.toFirestore());
  for (var obj in parsedJson) {
    var exerciseType = ExerciseType.fromJson(obj);
    exerciseCollection.add(exerciseType);
  }
}
