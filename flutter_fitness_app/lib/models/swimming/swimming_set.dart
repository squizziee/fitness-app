class SwimmingSet {
  bool? isPreset = false;
  bool? isUnderwaters = false;
  int? repetitions;
  double? distanceInMeters;
  Duration? time;
  String? notes = "";
  int setIndex;

  SwimmingSet(
      {this.isPreset,
      this.isUnderwaters,
      required this.repetitions,
      required this.distanceInMeters,
      required this.time,
      required this.setIndex,
      this.notes});
}
