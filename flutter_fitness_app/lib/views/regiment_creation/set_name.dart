import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_fitness_app/models/new_training_regiment.dart';
import 'package:flutter_fitness_app/views/regiment_creation/widgets/entry_field.dart';
import 'package:flutter_fitness_app/views/regiment_creation/widgets/title.dart';
import 'package:flutter_fitness_app/views/regiment_creation/widgets/submit_button.dart';

class SetNamePage extends StatefulWidget {
  const SetNamePage({super.key});

  @override
  State<SetNamePage> createState() => _SetNamePageState();
}

class _SetNamePageState extends State<SetNamePage> {
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
            title('Choose a name'),
            const SizedBox(
              height: 20,
            ),
            entryField(context, 'Type here', _controller),
            const SizedBox(
              height: 20,
            ),
            submitButton(context, () {
              Provider.of<NewTrainingRegiment>(context, listen: false)
                  .setName(_controller.text);
              Navigator.pushNamed(context, '/set_type');
            }, 'Next')
          ],
        ),
      ),
    );
  }
}
