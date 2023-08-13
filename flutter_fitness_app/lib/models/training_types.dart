//enum TrainingType { weightTraining, swimming, running, cycling, mixed }

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

abstract class TrainingType {
  FaIcon getIcon();
}

class WeightTraining extends TrainingType {
  @override
  String toString() {
    return "Weight training";
  }

  @override
  FaIcon getIcon() {
    return const FaIcon(FontAwesomeIcons.dumbbell);
  }
}

class Swimming extends TrainingType {
  @override
  String toString() {
    return "Swimming";
  }

  @override
  FaIcon getIcon() {
    return const FaIcon(FontAwesomeIcons.personSwimming);
  }
}

class Cycling extends TrainingType {
  @override
  String toString() {
    return "Cycling";
  }

  @override
  FaIcon getIcon() {
    return const FaIcon(FontAwesomeIcons.personRunning);
  }
}

class Running extends TrainingType {
  @override
  String toString() {
    return "Running";
  }

  @override
  FaIcon getIcon() {
    return const FaIcon(FontAwesomeIcons.bicycle);
  }
}

class Mixed extends TrainingType {
  @override
  String toString() {
    return "Mixed";
  }

  @override
  FaIcon getIcon() {
    return const FaIcon(FontAwesomeIcons.rotateRight);
  }
}

class Rowing extends TrainingType {
  @override
  String toString() {
    return "Rowing";
  }

  @override
  FaIcon getIcon() {
    return const FaIcon(FontAwesomeIcons.sailboat);
  }
}

class CombatTraining extends TrainingType {
  @override
  String toString() {
    return "Combat Training";
  }

  @override
  FaIcon getIcon() {
    return const FaIcon(FontAwesomeIcons.handFist);
  }
}

// extension ParseToString on TrainingType {
//   String toUIString() {
//     var temp = toString();
//     return toString().split('.').last;
//   }
// }
