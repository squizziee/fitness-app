import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/services/regiment_service.dart';
import 'package:flutter_fitness_app/views/regiment_creation/common_widgets/app_bar.dart';
import 'package:flutter_fitness_app/views/regiment_creation/widgets/number_entry_field.dart';
import 'package:flutter_fitness_app/views/regiment_creation/widgets/title.dart';
import 'package:flutter_fitness_app/views/regiment_creation/widgets/submit_button.dart';

class SetDurationPage extends StatefulWidget {
  const SetDurationPage({super.key});

  @override
  State<SetDurationPage> createState() => _SetDurationPageState();
}

class _SetDurationPageState extends State<SetDurationPage> {
  final TextEditingController _controller = TextEditingController();
  final RegimentService _regimentService = RegimentService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          appBar(context, "Create new regiment", "Choose regiment duration"),
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
              _regimentService.setCycleDurationInDays(
                  context, int.parse(_controller.text));
              Navigator.pushNamed(context, '/set_regiment_calendar');
            }, 'Next')
          ],
        ),
      ),
    );
  }
}
