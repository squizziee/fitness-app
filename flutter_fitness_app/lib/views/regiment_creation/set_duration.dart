import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/training_session.dart';
import 'package:flutter_fitness_app/models/training_types.dart';
import 'package:flutter_fitness_app/models/weight_training/weight_training_session.dart';
import 'package:flutter_fitness_app/views/regiment_creation/widgets/number_entry_field.dart';
import 'package:provider/provider.dart';

import 'package:flutter_fitness_app/models/new_training_regiment.dart';
import 'package:flutter_fitness_app/views/regiment_creation/widgets/title.dart';
import 'package:flutter_fitness_app/views/regiment_creation/widgets/submit_button.dart';

class SetDurationPage extends StatefulWidget {
  const SetDurationPage({super.key});

  @override
  State<SetDurationPage> createState() => _SetDurationPageState();
}

 void _createTrainingSessionAccordingToType(TrainingType type, BuildContext context, 
  TextEditingController controller) {
    if (type is WeightTraining) {
      Provider.of<NewTrainingRegiment>(context, listen: false).regiment.schedule = 
        List.filled(int.parse(controller.text), WeightTrainingSession());
      return;
    }
    throw Exception('Wrong training type $type');
 }

class _SetDurationPageState extends State<SetDurationPage> {
  final TextEditingController _controller = TextEditingController();

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
            title('Choose cycle duration'),
            const SizedBox(
              height: 20,
            ),
            numberEntryField(context, 'Type here', _controller),
            const SizedBox(
              height: 20,
            ),
            submitButton(context, () {
              Provider.of<NewTrainingRegiment>(context, listen: false).regiment
                  .cycleDurationInDays = int.parse(_controller.text);
              _createTrainingSessionAccordingToType(
                Provider.of<NewTrainingRegiment>(context, listen: false).regiment.trainingType!, context, _controller);
              Navigator.pushNamed(context, '/set_regiment_calendar');
            }, 'Next')
          ],
        ),
      ),
    );
  }
}
