import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectTrainingSessionPage extends StatefulWidget {
  const SelectTrainingSessionPage({super.key, required this.sessionIndex});

  final int sessionIndex;

  @override
  State<SelectTrainingSessionPage> createState() => _SelectTrainingSessionPageState();
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
    sessionIndex = widget.sessionIndex;
    return SafeArea(
      child: Column(children: [
        _addTrainingSessionButton(context),
        Text(sessionIndex.toString())
      ],),
    );
  }
}