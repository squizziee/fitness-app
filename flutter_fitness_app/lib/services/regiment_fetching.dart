import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_fitness_app/models/exercise_type.dart';
import 'package:flutter_fitness_app/models/training_regiment.dart';
import 'package:flutter_fitness_app/models/exercise.dart';
import 'package:flutter_fitness_app/models/training_session.dart';
import 'package:flutter_fitness_app/models/training_types.dart';
import 'package:flutter_fitness_app/models/weight_training/weight_training_exercise.dart';

abstract class DatabaseAPI {
  static var handlers = {
    'strength_training_sessions': WeightTrainingExerciseHandler()
  };

  static var exerciseCollections = ['strength_exercises'];

  static Future<List<TrainingRegiment>> getUserRegiments(
      String currentUserId) async {
    List<TrainingRegiment> result = [];
    var userCollection = FirebaseFirestore.instance.collection('users');
    var regimentCollection = FirebaseFirestore.instance.collection('regiments');

    // find user document in user collection
    var userSnapshot =
        await userCollection.where('user_uid', isEqualTo: currentUserId).get();

    for (var userInstance in userSnapshot.docs) {
      // iterate through user training regiments in user document
      var regiments = userInstance['regiments'];
      for (var userRegimentId in regiments) {
        // find user regiment in regiment collection by ID
        var regimentSnapshot = await regimentCollection
            .where(FieldPath.documentId, isEqualTo: userRegimentId)
            .get();

        assert(regimentSnapshot.docs.isNotEmpty);

        // filling TrainingRegiment model
        var name = regimentSnapshot.docs[0]['name'].toString();
        var notes = regimentSnapshot.docs[0]['notes'].toString();
        var schedule = List<TrainingSession>.empty(growable: true);
        var trainingType =
            getTrainingType(regimentSnapshot.docs[0]['training_type']);

        var scheduleSnapshot = regimentSnapshot.docs[0]['schedule'];
        for (var day in scheduleSnapshot) {
          var session = await getTrainingSessionByID(
              day['training_session'].toString().trim());

          session.dayInSchedule = day['day'];
          schedule.add(session);
        }
        var regiment = TrainingRegiment(
            name: name,
            notes: notes,
            trainingType: trainingType,
            schedule: schedule,
            cycleDurationInDays: schedule.length);
        regiment.id = userRegimentId;
        // model ready
        result.add(regiment);
      }
    }
    return result;
  }

  static TrainingType getTrainingType(dynamic str) {
    if (str == 'weightTraining') {
      return WeightTraining();
    }
    throw Exception('Wrong training type input');
  }

  static Future<WeightExerciseType> getExerciseTypeByID(String id) async {
    for (var collection in exerciseCollections) {
      var exerciseCollection =
          FirebaseFirestore.instance.collection(collection);
      var exerciseSnapshot = await exerciseCollection
          .where(FieldPath.documentId, isEqualTo: id)
          .get();
      if (exerciseSnapshot.docs.isEmpty) {
        continue;
      }
      var doc = exerciseSnapshot.docs[0];
      return WeightExerciseType(
          name: doc['name'],
          bodyPart: doc['bodypart'],
          iconURL: doc['icon_url'],
          category: doc['category']);
    }
    throw Exception('Wrong exercise ID has been provided');
  }

  static Future<TrainingSession> getTrainingSessionByID(String id) async {
    var result = TrainingSession();
    for (var key in handlers.keys) {
      var trainingSessionCollection =
          FirebaseFirestore.instance.collection(key);
      var trainingSessionQuerySnapshot = await trainingSessionCollection
          .where(FieldPath.documentId, isEqualTo: id)
          .get();
      var sessionName = trainingSessionQuerySnapshot.docs[0]['name'];
      var sessionNotes = trainingSessionQuerySnapshot.docs[0]['notes'];
      var exercises = trainingSessionQuerySnapshot.docs[0]['exercises'];
      for (var exerciseDatabaseInstance in exercises) {
        var exercise = await handlers[key]!.handle(exerciseDatabaseInstance);
        result.exercises.add(exercise);
      }
      result.name = sessionName;
      result.notes = sessionNotes;
      result.id = id;
    }
    return result;
  }
}

abstract class ExerciseHandler {
  Future<Exercise> handle(dynamic exerciseDatabaseInstance);
}

class WeightTrainingExerciseHandler implements ExerciseHandler {
  @override
  Future<Exercise> handle(dynamic exerciseDatabaseInstance) async {
    var setList = exerciseDatabaseInstance['Sets'];
    var exercise = WeightTrainingExercise();
    for (var setDatabseInstance in setList) {
      var set = WeightTrainingSet(
          notes: setDatabseInstance['notes'],
          repetitions: setDatabseInstance['repetitions'],
          weightInKilograms: setDatabseInstance['weight'],
          setIndex: setDatabseInstance['set_index']);
      exercise.sets.add(set);
    }
    exercise.exerciseType = await DatabaseAPI.getExerciseTypeByID(
        exerciseDatabaseInstance['exercise_link'].toString().trim());
    return exercise;
  }
}
