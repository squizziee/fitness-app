import 'package:flutter_fitness_app/models/exercise_type.dart';

class Exercise {
  ExerciseType _type = ExerciseType();
  String _bodyPartBias = '';
  String _notes = '';

  ExerciseType get type => _type;
  set type(ExerciseType value) => _type = value;

  String get bodyPartBias => _bodyPartBias;
  set bodyPartBias(String value) => _bodyPartBias = value;

  String get notes => _notes;
  set notes(String value) => _notes = value;
}
