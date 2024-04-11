import 'package:cloud_firestore/cloud_firestore.dart';

class RunningExerciseType {
  String name = '';
  String iconURL = '';

  RunningExerciseType({
    required this.name,
    required this.iconURL,
  });

  factory RunningExerciseType.fromJson(Map<String, dynamic> data) {
    final String name = data['name'];
    final String iconURL = data['icon_url'];
    return RunningExerciseType(name: name, iconURL: iconURL);
  }

  factory RunningExerciseType.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return RunningExerciseType(
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
