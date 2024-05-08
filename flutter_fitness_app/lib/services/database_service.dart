import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_app_serialization/app_user_serializer.dart';
import 'package:fitness_app_serialization/combat_training_firestore_serializer.dart';
import 'package:fitness_app_serialization/cycling_firestore_serializer.dart';
import 'package:fitness_app_serialization/firestore_serializer.dart';
import 'package:fitness_app_serialization/rowing_firestore_serializer.dart';
import 'package:fitness_app_serialization/running_firestore_serializer.dart';
import 'package:fitness_app_serialization/swimming_firestore_serializer.dart';
import 'package:fitness_app_serialization/weight_training_firestore_serializer.dart';
import 'package:flutter_fitness_app/models/combat_training/combat_training_session.dart';
import 'package:flutter_fitness_app/models/cycling/cycling_session.dart';
import 'package:flutter_fitness_app/models/rowing/rowing_session.dart';
import 'package:flutter_fitness_app/models/running/running_session.dart';
import 'package:flutter_fitness_app/models/swimming/swimming_session.dart';
import 'package:flutter_fitness_app/models/training_regiment.dart';
import 'package:flutter_fitness_app/models/training_session.dart';
import 'package:flutter_fitness_app/models/training_types.dart';
import 'package:flutter_fitness_app/models/user.dart';
import 'package:flutter_fitness_app/models/weight_training/weight_exercise_type.dart';
import 'package:flutter_fitness_app/models/weight_training/weight_training_session.dart';

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
class DatabaseService {
  static final Map<Type, FirestoreSerializer> _regimentSerializers = {
    WeightTraining: WeightTrainingFirestoreSerializer(),
    Swimming: SwimmingFirestoreSerializer(),
    Running: RunningFirestoreSerializer(),
    Cycling: CyclingFirestoreSerializer(),
    Rowing: RowingFirestoreSerializer(),
    CombatTraining: CombatTrainingFirestoreSerializer()
  };

  static final Map<Type, (String, FirestoreSerializer)> _sessionSerializers = {
    WeightTrainingSession: (
      "strength_training_sessions",
      WeightTrainingFirestoreSerializer()
    ),
    SwimmingSession: ("", SwimmingFirestoreSerializer()),
    RunningSession: ("", RunningFirestoreSerializer()),
    CyclingSession: ("", CyclingFirestoreSerializer()),
    RowingSession: ("", RowingFirestoreSerializer()),
    CombatTrainingSession: ("", CombatTrainingFirestoreSerializer())
  };

  Future<List<TrainingRegiment>> getUserRegiments(String userId) async {
    var db = FirebaseFirestore.instance;
    var user = (await db
            .collection("users")
            .where("user_uid", isEqualTo: userId)
            .get())
        .docs[0]
        .data();
    // var user = (await db.doc(userId).get()).data()!;
    FirestoreSerializer? serializer;

    // Final result to be stored here
    List<TrainingRegiment> regiments = [];
    // Iterate through all regiments
    if (user["regiments"] == null) {
      return regiments;
    }
    for (var regimentRef in user["regiments"]) {
      var regimentDoc = (await regimentRef.get()).data()!;
      if (getTrainingType(regimentDoc["training_type"]) is WeightTraining) {
        serializer = WeightTrainingFirestoreSerializer();
      }
      var regiment =
          await serializer!.deserializeRegiment(regimentDoc, regimentRef);
      regiments.add(regiment);
    }
    return regiments;
  }

  void postAppUser(AppUser user) async {
    var db = FirebaseFirestore.instance;
    var collection = db.collection("users");
    var doc =
        (await collection.where("user_uid", isEqualTo: user.userUID).get())
            .docs[0]
            .reference;

    // If the regiment is new, create Firestore doc for it and put it in object as a field
    await doc.set(AppUserSerializer().serialize(user));
  }

  // Works assuming all training sessions are posted already
  void postRegiment(TrainingRegiment regiment) async {
    var db = FirebaseFirestore.instance;
    FirestoreSerializer serializer =
        _regimentSerializers[regiment.trainingType.runtimeType]!;
    var collection = db.collection("regiments");
    var regimentDoc = regiment.id;
    if (regimentDoc == null) {
      regimentDoc = collection.doc();
      regiment.id = regimentDoc;
    }

    // If the regiment is new, create Firestore doc for it and put it in object as a field
    await regimentDoc.set(serializer.serializeRegiment(regiment));
  }

  void postSession(TrainingSession session) async {
    var db = FirebaseFirestore.instance;
    FirestoreSerializer serializer =
        _sessionSerializers[session.runtimeType]!.$2;
    var collection =
        db.collection(_sessionSerializers[session.runtimeType]!.$1);
    var sessionDoc = session.id;
    if (sessionDoc == null) {
      sessionDoc = collection.doc();
      session.id = sessionDoc;
    }

    var temp = serializer.serializeSession(session);
    // If the session is new, create Firestore doc for it and put it in object as a field
    await sessionDoc.set(temp);
  }

  TrainingType getTrainingType(String str) {
    if (str == "Weight training") {
      return WeightTraining();
    }
    throw Exception("No such training type");
  }

  Future<List<WeightExerciseType>> loadWeightExerciseList() async {
    var exerciseCollection =
        FirebaseFirestore.instance.collection('strength_exercises');
    var exerciseSnapshot = await exerciseCollection.get();
    List<WeightExerciseType> result = [];
    for (var doc in exerciseSnapshot.docs) {
      if (doc.reference == null) {
        print("funny\n\n");
      }
      result.add(WeightExerciseType(
          name: doc['name'],
          bodyPart: doc['bodypart'],
          iconURL: doc['icon_url'],
          category: doc['category'],
          id: doc.reference));
    }
    return result;
  }
}
