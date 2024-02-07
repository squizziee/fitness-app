import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/OpenedTrainingSession.dart';
import 'package:flutter_fitness_app/views/regiment_creation/training_session_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SelectTrainingSessionPage extends StatefulWidget {
  const SelectTrainingSessionPage({super.key});

  @override
  State<SelectTrainingSessionPage> createState() => _SelectTrainingSessionPageState();
}

Widget _addTrainingSessionButton(BuildContext context, int index) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).pushNamed('/training_session_screen');
    },
    child: Container(
      padding: const EdgeInsets.all(30),
      width: double.infinity,
      decoration: const BoxDecoration(color: Color.fromARGB(31, 180, 180, 180)),
      child: Wrap(alignment: WrapAlignment.center, children: [
        const FaIcon(FontAwesomeIcons.plus),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            'Add new session'.toUpperCase(),
            style:
                GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        )
      ]),
    ),
  );
}

class _SelectTrainingSessionPageState extends State<SelectTrainingSessionPage> {

  int sessionIndex = -1;

  @override
  Widget build(BuildContext context) {
    sessionIndex = Provider.of<OpenedTrainingSession>(context).sessionIndex;
    return SafeArea(
      child: Column(children: [
        _addTrainingSessionButton(context, sessionIndex),
        Text(sessionIndex.toString())
      ],),
    );
  }
}