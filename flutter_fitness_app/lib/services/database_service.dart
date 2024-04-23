import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_app_serialization/weight_training_firestore_serializer.dart';
import 'package:flutter_fitness_app/models/training_regiment.dart';
import 'package:flutter_fitness_app/models/training_types.dart';

// TODO Rewrite all this to instances
// abstract class DatabaseService {
//   static var handlers = {'strength_training_sessions': WeightTrainingHandler()};

//   static var exerciseCollections = ['strength_exercises'];

//   static Future<List<TrainingRegiment>> getUserRegiments(
//       String currentUserId) async {
//     List<TrainingRegiment> result = [];
//     var userCollection = FirebaseFirestore.instance.collection('users');
//     var regimentCollection = FirebaseFirestore.instance.collection('regiments');

//     // find user document in user collection
//     var userSnapshot =
//         await userCollection.where('user_uid', isEqualTo: currentUserId).get();

//     for (var userInstance in userSnapshot.docs) {
//       // iterate through user training regiments in user document
//       var regiments = userInstance['regiments'];
//       for (var userRegimentId in regiments) {
//         // find user regiment in regiment collection by ID
//         var regimentSnapshot = await regimentCollection
//             .where(FieldPath.documentId, isEqualTo: userRegimentId)
//             .get();

//         assert(regimentSnapshot.docs.isNotEmpty);

//         // filling TrainingRegiment model
//         var name = regimentSnapshot.docs[0]['name'].toString();
//         var notes = regimentSnapshot.docs[0]['notes'].toString();
//         var schedule = List<TrainingSession>.empty(growable: true);
//         var trainingType =
//             getTrainingType(regimentSnapshot.docs[0]['training_type']);

//         //var scheduleSnapshot = regimentSnapshot.docs[0]['schedule'];
//         // for (var day in scheduleSnapshot) {
//         //   var session = await getTrainingSessionByID(
//         //       day['training_session'].toString().trim());

//         //   session.dayInSchedule = day['day'];
//         //   schedule.add(session);
//         // }
//         var regiment = TrainingRegiment(
//             name: name,
//             notes: notes,
//             trainingType: trainingType,
//             schedule: schedule,
//             cycleDurationInDays: schedule.length);
//         regiment.id = userRegimentId;
//         // model ready
//         result.add(regiment);
//       }
//     }
//     return result;
//   }

//   // static Future<List<TrainingRegiment>> getUserRegiments(String userId) async {
//   //   List<TrainingRegiment> result = [];
//   //   var userCollection = FirebaseFirestore.instance.collection('users');
//   //   var userSnapshot = await userCollection.doc("users/$userId").get();

//   //   assert(userSnapshot.data()!.isNotEmpty);

//   //   var regimentIdList = userSnapshot.data()!["regiments"];
//   //   for (var regimentId in regimentIdList) {
//   //     result.add(getRegiment(regimentId));
//   //   }
//   //   return result;
//   // }

//   // static TrainingRegiment getRegiment(dynamic reference) {
//   //   var regimentCollection = FirebaseFirestore.instance.collection('regiments');
//   //   if (reference.get()) {

//   //   }
//   // }

//   static TrainingType getTrainingType(dynamic str) {
//     if (str == 'weightTraining') {
//       return WeightTraining();
//     }
//     throw Exception('Wrong training type input');
//   }

//   static Future<WeightExerciseType> getExerciseTypeByID(String id) async {
//     for (var collection in exerciseCollections) {
//       var exerciseCollection =
//           FirebaseFirestore.instance.collection(collection);
//       var exerciseSnapshot = await exerciseCollection
//           .where(FieldPath.documentId, isEqualTo: id)
//           .get();
//       if (exerciseSnapshot.docs.isEmpty) {
//         continue;
//       }
//       var doc = exerciseSnapshot.docs[0];
//       return WeightExerciseType(
//           name: doc['name'],
//           bodyPart: doc['bodypart'],
//           iconURL: doc['icon_url'],
//           category: doc['category']);
//     }
//     throw Exception('Wrong exercise ID has been provided');
//   }

//   // static Future<TrainingSession> getTrainingSessionByID(String id) async {
//   //   var result = TrainingSession();
//   //   for (var key in handlers.keys) {
//   //     var trainingSessionCollection =
//   //         FirebaseFirestore.instance.collection(key);
//   //     var trainingSessionQuerySnapshot = await trainingSessionCollection
//   //         .where(FieldPath.documentId, isEqualTo: id)
//   //         .get();
//   //     var sessionName = trainingSessionQuerySnapshot.docs[0]['name'];
//   //     var sessionNotes = trainingSessionQuerySnapshot.docs[0]['notes'];
//   //     var exercises = trainingSessionQuerySnapshot.docs[0]['exercises'];
//   //     for (var exerciseDatabaseInstance in exercises) {
//   //       var exercise = await handlers[key]!.handle(exerciseDatabaseInstance);
//   //       result.exercises.add(exercise);
//   //     }
//   //     result.name = sessionName;
//   //     result.notes = sessionNotes;
//   //     result.id = id;
//   //   }
//   //   return result;
//   // }
// }
// TODO Rewrite this to just call each session serialization
class DatabaseService {
  Future<List<TrainingRegiment>> getUserRegiments(String userId) async {
    var db = FirebaseFirestore.instance;
    var user = (await db.doc(userId).get()).data()!;
    var serializer = WeightTrainingFirestoreSerializer();

    // Final result to be stored here
    List<TrainingRegiment> regiments = [];
    //var obj = (await db.doc(userId).get()).data;
    // Iterate through all regiment refs, e.g. /regiments/random_id_string
    for (var regimentRef in user["regiments"]) {
      var regimentDoc = (await regimentRef.get()).data()!;
      var regiment =
          await serializer.deserializeRegiment(regimentDoc, regimentRef);
      regiments.add(regiment);
    }
    return regiments;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getExerciseTypeByID(
      ref) async {
    return ref.get();
  }

  TrainingType getTrainingType(String str) {
    if (str == "weightTraining") {
      return WeightTraining();
    }
    throw Exception("No such training type");
  }
}
