import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_fitness_app/models/exercise_type.dart';

Future<List<ExerciseType>> loadExerciseList() async {
  var exerciseCollection =
      FirebaseFirestore.instance.collection('strength_exercises');
  var exerciseSnapshot = await exerciseCollection.get();
  List<ExerciseType> result = [];
  for (var doc in exerciseSnapshot.docs) {
    result.add(ExerciseType(
        name: doc['name'],
        bodyPart: doc['bodypart'],
        iconURL: doc['icon_url'],
        category: doc['category']));
  }
  return result;
}
