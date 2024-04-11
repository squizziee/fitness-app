class SwimmingSet {
  bool? isPreset = false;
  bool? isUnderwaters = false;
  int? repetitions;
  double? distanceInMeters;
  Duration? time;
  String? notes = "";

  SwimmingSet(
      {this.isPreset,
      this.isUnderwaters,
      required this.repetitions,
      required this.distanceInMeters,
      required this.time,
      this.notes});
}
