import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/training_types.dart';
import 'package:provider/provider.dart';

import 'package:flutter_fitness_app/models/training_regiment.dart';
import 'package:flutter_fitness_app/views/first_use/widgets/title.dart';
import 'package:flutter_fitness_app/views/first_use/widgets/submit_button.dart';

class SetTypePage extends StatefulWidget {
  const SetTypePage({super.key});

  @override
  State<SetTypePage> createState() => _SetTypePageState();
}

class _SetTypePageState extends State<SetTypePage> {
  final TextEditingController _controller = TextEditingController();

  int _value = -1;
  List<TrainingType> trainingTypeOptions = [
    WeightTraining(),
    Swimming(),
    Running(),
    Cycling(),
    Rowing(),
    CombatTraining(),
    Mixed(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      avatar: trainingTypeOptions[index].getIcon(),
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
              Provider.of<TrainingRegiment>(context, listen: false)
                  .setTrainingType(trainingTypeOptions[_value]);
            }, 'Next')
          ],
        ),
      ),
    );
  }
}
