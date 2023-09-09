//enum TrainingType { weightTraining, swimming, running, cycling, mixed }

import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

abstract class TrainingType {
  IconData getIconData();
}

class WeightTraining extends TrainingType {
  @override
  String toString() {
    return "Weight training";
  }

  @override
  IconData getIconData() {
    return FontAwesomeIcons.dumbbell;
  }
}

class Swimming extends TrainingType {
  @override
  String toString() {
    return "Swimming";
  }

  @override
  IconData getIconData() {
    return FontAwesomeIcons.personSwimming;
  }
}

class Cycling extends TrainingType {
  @override
  String toString() {
    return "Cycling";
  }

  @override
  IconData getIconData() {
    return FontAwesomeIcons.personRunning;
  }
}

class Running extends TrainingType {
  @override
  String toString() {
    return "Running";
  }

  @override
  IconData getIconData() {
    return FontAwesomeIcons.bicycle;
  }
}

class Mixed extends TrainingType {
  @override
  String toString() {
    return "Mixed";
  }

  @override
  IconData getIconData() {
    return FontAwesomeIcons.rotateRight;
  }
}

class Rowing extends TrainingType {
  @override
  String toString() {
    return "Rowing";
  }

  @override
  IconData getIconData() {
    return FontAwesomeIcons.sailboat;
  }
}

class CombatTraining extends TrainingType {
  @override
  String toString() {
    return "Combat Training";
  }

  @override
  IconData getIconData() {
    return FontAwesomeIcons.handFist;
  }
}

// extension ParseToString on TrainingType {
//   String toUIString() {
//     var temp = toString();
//     return toString().split('.').last;
//   }
// }
