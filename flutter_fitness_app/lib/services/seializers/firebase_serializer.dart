import 'package:flutter_fitness_app/models/training_regiment.dart';

class FirebaseSerializer {
  Map<String, Object?> serializeRegiment(TrainingRegiment regiment) {
    var id = regiment.id;
    var sessionIdList = [];
    for (var session in regiment.schedule!) {
      sessionIdList.add(session.id);
    }
    var serialized = {
      "name": regiment.name,
      "notes": regiment.notes,
      "training_type": regiment.trainingType.toString(),
      "schedule": sessionIdList,
      "start_date": regiment.startDate
    };
    return serialized;
  }
}
