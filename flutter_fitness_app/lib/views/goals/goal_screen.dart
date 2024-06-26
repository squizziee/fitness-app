import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/base/goal.dart';
import 'package:flutter_fitness_app/models/base/user.dart';
import 'package:flutter_fitness_app/services/goal_service.dart';
import 'package:flutter_fitness_app/views/regiment_creation/common_widgets/dialog.dart';
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
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(35),
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(width: 0.5, color: Color.fromRGBO(0, 0, 0, .1)),
            top: BorderSide(width: 0.5, color: Color.fromRGBO(0, 0, 0, .1))),
      ),
      child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 10,
          alignment: WrapAlignment.center,
          children: [
            FaIcon(
              FontAwesomeIcons.plus,
              size: 16,
            ),
            Text(
              "Add new goal".toUpperCase(),
              style:
                  GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ]),
    ),
  );
}

class _GoalScreenState extends State<GoalScreen> {
  final GoalService _goalService = GoalService();

  Widget _goalWidget(BuildContext context, Goal goal, int index) {
    var daysLeft = goal.deadline!.difference(DateTime.now()).inDays;
    var isDue = daysLeft < 0;

    return GestureDetector(
      onTap: () {
        _goalService.openGoalByReference(context, goal);
        Navigator.of(context).pushNamed("/set_goal").then((value) => setState(
              () {},
            ));
      },
      onLongPress: () => showDialog<String>(
        context: context,
        builder: (context) => defaultDialog(
            title: "Delete ${goal.exerciseType!.name}?",
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    _goalService.openGoal(context, index);
                    _goalService.removeGoalByIndex(context, index);
                    setState(() {});
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Delete',
                    style: TextStyle(color: Colors.redAccent),
                  ))
            ]),
      ),
      child: Opacity(
        opacity: isDue ? 0.5 : 1.0,
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
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Text(
                    goal.exerciseType!.name,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w800, fontSize: 20),
                  ),
                ),
                Wrap(
                  spacing: 5,
                  children: [
                    tagWidget(
                        isDue ? "Due" : "${daysLeft} days left", Colors.black),
                    tagWidget("${goal.metrics!.length} metrics",
                        Theme.of(context).primaryColor,
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
                  return _goalWidget(context, goals[index], index);
                }),
          ),
        ],
      )),
    ));
  }
}
