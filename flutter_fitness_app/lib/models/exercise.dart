import 'package:flutter/widgets.dart';
import 'package:flutter_fitness_app/models/exercise_type.dart';

class Exercise {
  ExerciseType? exerciseType;
  String notes = '';

  Widget getExercisePreviewWidgetLayout() {
    return const Text('no layout');
  }
}
