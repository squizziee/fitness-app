import 'package:cloud_firestore/cloud_firestore.dart';

class WeightExerciseType {
  dynamic id;
  String name = '';
  String bodyPart = '';
  String iconURL = '';
  String category = '';

  WeightExerciseType(
      {this.id,
      required this.name,
      required this.bodyPart,
      required this.iconURL,
      required this.category});

  factory WeightExerciseType.fromJson(Map<String, dynamic> data) {
    final String name = data['name'];
    final String bodyPart = data['bodypart'];
    final String iconURL = data['icon_url'];
    final String category = data['category'];
    return WeightExerciseType(
        name: name, bodyPart: bodyPart, iconURL: iconURL, category: category);
  }

  factory WeightExerciseType.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return WeightExerciseType(
        name: data?['name'],
        bodyPart: data?['bodypart'],
        iconURL: data?['icon_url'],
        category: data?['category']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      "name": name,
      "bodypart": bodyPart,
      "icon_url": iconURL,
      "category": category
    };
  }
}
