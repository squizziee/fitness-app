import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/base/goal.dart';
import 'package:flutter_fitness_app/models/base/user.dart';
import 'package:flutter_fitness_app/services/goal_service.dart';
import 'package:flutter_fitness_app/views/regiment_creation/common_widgets/tag_widget.dart';
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

class _GoalScreenState extends State<GoalScreen> {
  final GoalService _goalService = GoalService();

  Widget _goalWidget(
      BuildContext context, Goal goal, GoalService goalService, int index) {
    return GestureDetector(
      onTap: () {
        goalService.openGoalByReference(context, goal);
        Navigator.of(context).pushNamed("/set_goal").then((value) => setState(
              () {},
            ));
      },
      onLongPress: () => showDialog<String>(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Confirmation'),
                content: Text(
                    'Are you sure you want to delete "${goal.exerciseType!.name}" metric?'),
                actions: <Widget>[
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel')),
                  TextButton(
                      onPressed: () {
                        goalService.openGoal(context, index);
                        goalService.removeGoalByIndex(context, index);
                        setState(() {});
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Delete',
                        style: TextStyle(color: Colors.redAccent),
                      )),
                ],
              )),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 0.5, color: Color.fromRGBO(0, 0, 0, .1)))),
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                goal.exerciseType!.name,
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w800, fontSize: 20),
              ),
              Wrap(
                spacing: 5,
                children: [
                  tagWidget(
                      "${goal.deadline!.difference(DateTime.now()).inDays} days left",
                      Colors.black),
                  tagWidget(
                      "${goal.metrics!.length} metrics", Colors.greenAccent,
                      textColor: Colors.black),
                ],
              )
            ]),
            Container(
              width: 30,
              height: 30,
              child: Stack(clipBehavior: Clip.none, children: [
                Positioned(
                  right: 0,
                  top: 0,
                  child: FractionalTranslation(
                    translation: const Offset(.5, -0.05),
                    child: Opacity(
                      opacity: .35,
                      child: Image.asset(
                        'assets/target.png',
                        height: 140,
                      ),
                    ),
                  ),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }

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
                  return _goalWidget(
                      context, goals[index], _goalService, index);
                }),
          ),
        ],
      )),
    ));
  }
}
