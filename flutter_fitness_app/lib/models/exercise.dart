abstract class Exercise {
  String id = "";
  String notes = '';

  Exercise({required this.notes, required this.id});

  String getExerciseTypeName();
}
