import 'package:cloud_firestore/cloud_firestore.dart';

class SwimmingExerciseType {
  String name = '';
  String iconURL = '';

  SwimmingExerciseType({
    required this.name,
    required this.iconURL,
  });

  factory SwimmingExerciseType.fromJson(Map<String, dynamic> data) {
    final String name = data['name'];
    final String iconURL = data['icon_url'];
    return SwimmingExerciseType(name: name, iconURL: iconURL);
  }

  factory SwimmingExerciseType.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return SwimmingExerciseType(
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
