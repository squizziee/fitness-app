abstract class Exercise {
  dynamic id;
  String notes = '';

  Exercise({required this.notes, required this.id});

  String getExerciseTypeName();
}
