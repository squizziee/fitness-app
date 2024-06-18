import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/services/regiment_service.dart';
import 'package:flutter_fitness_app/views/regiment_creation/common_widgets/app_bar.dart';
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
  final RegimentService _regimentService = RegimentService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(context, "Create new regiment", "Choose name"),
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
              _regimentService.createAndOpenEmptyRegiment(context);
              _regimentService.setName(context, _controller.text);
              Navigator.pushNamed(context, '/set_type');
            }, 'Next')
          ],
        ),
      ),
    );
  }
}
