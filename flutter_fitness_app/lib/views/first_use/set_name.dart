import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_fitness_app/models/training_regiment.dart';
import 'package:flutter_fitness_app/views/first_use/widgets/entry_field.dart';
import 'package:flutter_fitness_app/views/first_use/widgets/title.dart';
import 'package:flutter_fitness_app/views/first_use/widgets/submit_button.dart';

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
            title(),
            const SizedBox(
              height: 40,
            ),
            entryField(context, 'Type here', _controller),
            const SizedBox(
              height: 20,
            ),
            submitButton(context, () {
              Provider.of<TrainingRegiment>(context, listen: false)
                  .setName(_controller.text);
            })
          ],
        ),
      ),
    );
  }
}
