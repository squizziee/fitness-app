import 'package:cloud_firestore/cloud_firestore.dart';

class RowingExerciseType {
  String name = '';
  String iconURL = '';

  RowingExerciseType({
    required this.name,
    required this.iconURL,
  });

  factory RowingExerciseType.fromJson(Map<String, dynamic> data) {
    final String name = data['name'];
    final String iconURL = data['icon_url'];
    return RowingExerciseType(name: name, iconURL: iconURL);
  }

  factory RowingExerciseType.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return RowingExerciseType(
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
