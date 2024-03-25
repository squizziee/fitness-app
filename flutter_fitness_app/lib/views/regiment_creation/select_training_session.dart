import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectTrainingSessionPage extends StatefulWidget {
  const SelectTrainingSessionPage({super.key});

  @override
  State<SelectTrainingSessionPage> createState() =>
      _SelectTrainingSessionPageState();
}

Widget _addTrainingSessionButton(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).pushNamed('/training_session_screen');
    },
    child: Container(
      padding: const EdgeInsets.all(30),
      width: double.infinity,
      decoration: const BoxDecoration(color: Color.fromARGB(31, 180, 180, 180)),
      child: Wrap(alignment: WrapAlignment.center, children: [
        const FaIcon(
          FontAwesomeIcons.pen,
          size: 18,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            'Edit session'.toUpperCase(),
            style:
                GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        )
      ]),
    ),
  );
}

class _SelectTrainingSessionPageState extends State<SelectTrainingSessionPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _addTrainingSessionButton(context),
            const Text('To be continued')
          ],
        ),
      ),
    );
  }
}
