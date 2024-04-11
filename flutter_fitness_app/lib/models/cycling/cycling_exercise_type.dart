import 'package:cloud_firestore/cloud_firestore.dart';

class CyclingExerciseType {
  String name = '';
  String iconURL = '';

  CyclingExerciseType({
    required this.name,
    required this.iconURL,
  });

  factory CyclingExerciseType.fromJson(Map<String, dynamic> data) {
    final String name = data['name'];
    final String iconURL = data['icon_url'];
    return CyclingExerciseType(name: name, iconURL: iconURL);
  }

  factory CyclingExerciseType.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return CyclingExerciseType(
      name: data?['name'],
      iconURL: data?['icon_url'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "name": name,
      "icon_url": iconURL,
    };
  }
}
