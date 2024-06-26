import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/base/training_types.dart';
import 'package:flutter_fitness_app/services/regiment_service.dart';
import 'package:flutter_fitness_app/views/regiment_creation/common_widgets/app_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_fitness_app/views/regiment_creation/widgets/title.dart';
import 'package:flutter_fitness_app/views/regiment_creation/widgets/submit_button.dart';

class SetTypePage extends StatefulWidget {
  const SetTypePage({super.key});

  @override
  State<SetTypePage> createState() => _SetTypePageState();
}

class _SetTypePageState extends State<SetTypePage> {
  int _value = -1;
  final RegimentService _regimentService = RegimentService();

  List<TrainingType> trainingTypeOptions = [
    WeightTraining(),
    Swimming(),
    Running(),
    Cycling(),
    Rowing(),
    CombatTraining(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          defaultAppBar(context, "Create new regiment", "Choose training type"),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            title('Choose training type'),
            const SizedBox(
              height: 40,
            ),
            Wrap(
                spacing: 8,
                alignment: WrapAlignment.center,
                children: List<Widget>.generate(
                  trainingTypeOptions.length,
                  (int index) {
                    return InputChip(
                      label: Text(trainingTypeOptions[index].toString()),
                      selected: _value == index,
                      avatar: FaIcon(trainingTypeOptions[index].getIconData()),
                      onSelected: (bool selected) {
                        setState(() {
                          _value = selected ? index : 0;
                        });
                      },
                      showCheckmark: false,
                    );
                  },
                ).toList()),
            const SizedBox(
              height: 40,
            ),
            submitButton(context, () {
              _regimentService.setTrainingType(
                  context, trainingTypeOptions[_value]);
              Navigator.pushNamed(context, '/set_duration');
            }, 'Next')
          ],
        ),
      ),
    );
  }
}
