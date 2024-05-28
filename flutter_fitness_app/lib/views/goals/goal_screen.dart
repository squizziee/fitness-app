import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/goal.dart';
import 'package:flutter_fitness_app/models/user.dart';
import 'package:flutter_fitness_app/services/goal_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class GoalScreen extends StatefulWidget {
  const GoalScreen({super.key});

  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

Widget _addGoalButton(BuildContext context, GoalService goalService) {
  return GestureDetector(
    onTap: () async {
      await goalService
          .createAndOpenEmptyGoal(context)
          .then((value) => Navigator.of(context).pushNamed('/set_goal'));
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
            'Add new goal'.toUpperCase(),
            style:
                GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        )
      ]),
    ),
  );
}

Widget _goalWidget(BuildContext context, Goal goal, GoalService goalService) {
  return GestureDetector(
    onTap: () {
      goalService.openGoalByReference(context, goal);
      Navigator.of(context).pushNamed("/set_goal");
    },
    child: Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(20),
      child: Column(children: [
        Text(goal.exerciseType!.name),
        Text("${goal.deadline!}"),
        Text("${goal.metrics!.length} metrics"),
      ]),
    ),
  );
}

class _GoalScreenState extends State<GoalScreen> {
  final GoalService _goalService = GoalService();

  @override
  Widget build(BuildContext context) {
    var goals = Provider.of<AppUser>(context).goals;
    return SafeArea(
        child: Scaffold(
      body: Container(
          child: Column(
        children: [
          _addGoalButton(context, _goalService),
          Expanded(
            child: ListView.builder(
                itemCount: goals!.length,
                itemBuilder: (context, index) {
                  return _goalWidget(context, goals[index], _goalService);
                }),
          ),
        ],
      )),
    ));
  }
}
