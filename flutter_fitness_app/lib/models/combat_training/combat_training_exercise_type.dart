import 'package:cloud_firestore/cloud_firestore.dart';

class CombatTrainingExerciseType {
  String name = '';
  String? style = '';
  String iconURL = '';

  CombatTrainingExerciseType({
    required this.name,
    this.style,
    required this.iconURL,
  });

  factory CombatTrainingExerciseType.fromJson(Map<String, dynamic> data) {
    final String name = data['name'];
    final String iconURL = data['icon_url'];
    return CombatTrainingExerciseType(name: name, iconURL: iconURL);
  }

  factory CombatTrainingExerciseType.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return CombatTrainingExerciseType(
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
