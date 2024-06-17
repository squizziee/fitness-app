abstract class Exercise {
  String? notes = '';

  Exercise({required this.notes});

  String getExerciseTypeName();

  String getImageUrl() {
    return "";
  }

  String getMainMetricText() {
    return "No main metric";
  }

  String getSecondaryMetricText() {
    return "No secondary metric";
  }
}
