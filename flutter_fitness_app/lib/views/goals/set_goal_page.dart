import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/base/goal.dart';
import 'package:flutter_fitness_app/models/weight_training/weight_exercise_type.dart';
import 'package:flutter_fitness_app/repos/current_goal.dart';
import 'package:flutter_fitness_app/services/custom_search_delegate.dart';
import 'package:flutter_fitness_app/services/database_service.dart';
import 'package:flutter_fitness_app/services/goal_service.dart';
import 'package:flutter_fitness_app/views/misc/bottom_border.dart';
import 'package:flutter_fitness_app/views/misc/default_text_field.dart';
import 'package:flutter_fitness_app/views/regiment_creation/common_widgets/app_bar.dart';
import 'package:flutter_fitness_app/views/regiment_creation/common_widgets/dialog.dart';
import 'package:flutter_fitness_app/views/regiment_creation/common_widgets/tag_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SetGoalPage extends StatefulWidget {
  const SetGoalPage({super.key});

  @override
  State<SetGoalPage> createState() => _SetGoalPageState();
}

class _SetGoalPageState extends State<SetGoalPage> {
  Future<List<WeightExerciseType>>? exerciseList;
  final DatabaseService _dbService = DatabaseService();
  final GoalService _goalService = GoalService();
  WeightExerciseType? currentExercise;
  DateTime? datePicked;

  final TextEditingController _metricNameController = TextEditingController();
  final TextEditingController _metricSizeController = TextEditingController();
  final TextEditingController _metricScaleController = TextEditingController();

  void _clearControllers() {
    _metricNameController.text = "";
    _metricSizeController.text = "";
    _metricScaleController.text = "";
  }

  Widget _addMetricButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom:
                  BorderSide(width: 0.5, color: Color.fromRGBO(0, 0, 0, .1)))),
      child: GestureDetector(
        onTap: () => showDialog(
            context: context,
            builder: (context) => defaultDialog(title: "Add metric", content: [
                  defaultTextField(
                      inputType: TextInputType.text,
                      controller: _metricNameController,
                      placeholder: "Name"),
                  defaultTextField(
                      inputType: TextInputType.number,
                      controller: _metricSizeController,
                      placeholder: "Size"),
                  defaultTextField(
                      inputType: TextInputType.text,
                      controller: _metricScaleController,
                      placeholder: "Scale (can be empty)"),
                ], actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () async {
                      await _goalService
                          .addMetric(context, _metricNameController.text,
                              double.parse(_metricSizeController.text),
                              metricScale: _metricScaleController.text)
                          .then((value) => Navigator.pop(context, 'OK'));
                      _clearControllers();
                      setState(() {});
                    },
                    child: const Text('OK'),
                  ),
                ])),
        child: Container(
            height: 50,
            width: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white,
                border:
                    Border.all(width: 0.5, color: Color.fromRGBO(0, 0, 0, .1)),
                borderRadius: BorderRadius.all(Radius.circular(50))),
            child: const FaIcon(
              FontAwesomeIcons.plus,
              size: 18,
            )),
      ),
    );
  }

  Widget _deadlineWidget(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(border: bottomBorder()),
      padding: EdgeInsets.all(20),
      child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.spaceBetween,
          children: [
            Text(
              datePicked == null
                  ? "No deadline selected"
                  : "Due on ${DateFormat.yMMMd().format(datePicked!)}",
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w800, fontSize: 20),
            ),
            GestureDetector(
              onTap: () async {
                datePicked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(Duration(days: 1001)),
                );
                if (datePicked != null) {
                  await _goalService.updateDeadline(context, datePicked!);
                }
                setState(() {});
              },
              child: FaIcon(
                FontAwesomeIcons.pen,
                size: 16,
              ),
            )
          ]),
    );
  }

  Widget _metricWidget(BuildContext context, GoalMetric metric,
      GoalService goalService, int index) {
    return GestureDetector(
      onLongPress: () => showDialog<String>(
        context: context,
        builder: (context) =>
            defaultDialog(title: "Delete ${metric.metricName}?", actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel')),
          TextButton(
              onPressed: () {
                //goalService.deleteMetric(context, metric.metricName!);
                goalService.deleteMetricByIndex(context, index);
                setState(() {});
                Navigator.of(context).pop();
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.redAccent),
              )),
        ]),
      ),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(border: bottomBorder()),
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 40,
              child: Wrap(
                  spacing: 5,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    Container(
                      width: (MediaQuery.of(context).size.width - 40) * 0.5,
                      child: Text(
                        "${metric.metricName}",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w800, fontSize: 15),
                      ),
                    ),
                    Container(
                      width: (MediaQuery.of(context).size.width - 40) * 0.48,
                      alignment: Alignment.centerRight,
                      child: Text(
                        "${metric.metricSize}${metric.metricScale == "" ? "" : " "}${metric.metricScale}",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w800, fontSize: 15),
                      ),
                    ),
                    // tagWidget("${metric.metricSize}${metric.metricScale}",
                    //     Colors.black)
                  ]),
            ),
            //positionedImage(imageSrc: "assets/productivity.png", size: 100)
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    exerciseList = _dbService.loadWeightExerciseList();
  }

  @override
  Widget build(BuildContext context) {
    var currentGoal = Provider.of<CurrentGoal>(context).goal!;
    currentExercise = currentGoal.exerciseType;
    datePicked = currentGoal.deadline;
    return SafeArea(
        child: Scaffold(
      appBar: defaultAppBar(
          context,
          currentGoal.exerciseType == null
              ? "New goal"
              : "${currentGoal.exerciseType!.name} goal",
          "Goal setup"),
      body: Column(children: [
        FutureBuilder(
            future: exerciseList,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return GestureDetector(
                  onTap: () async {
                    await showSearch(
                            context: context,
                            delegate: CustomSearchDelegate(snapshot.data))
                        .then((type) {
                      _goalService.updateExercise(context, type);
                      currentExercise = type;
                    });
                    setState(() {});
                  },
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                            color: Color.fromRGBO(0, 0, 0, 0.05), width: 1),
                      )),
                      child: Row(children: [
                        Container(
                            padding: EdgeInsets.all(20),
                            child: currentExercise == null
                                ? const Icon(Icons.search)
                                : Image.network(
                                    currentExercise!.iconURL,
                                    width: 50,
                                  )),
                        Container(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            currentExercise == null
                                ? Text('No exercise chosen',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        height: 1))
                                : Container(
                                    child: Text(currentExercise!.name,
                                        overflow: TextOverflow.fade,
                                        style: GoogleFonts.montserrat(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w800,
                                            height: 1))),
                            SizedBox(
                              height: 5,
                            ),
                            currentExercise == null
                                ? SizedBox()
                                : Wrap(
                                    spacing: 5,
                                    children: [
                                      tagWidget(currentExercise!.bodyPart,
                                          Colors.black),
                                      tagWidget(currentExercise!.category,
                                          Theme.of(context).primaryColor),
                                    ],
                                  )
                          ],
                        ))
                      ])),
                );
              }
            }),
        _deadlineWidget(context),
        _addMetricButton(context),
        Expanded(
          child: ListView.builder(
              itemCount: currentGoal.metrics!.length,
              itemBuilder: (context, index) {
                var metric = currentGoal.metrics!.toList()[index];
                return _metricWidget(context, metric, _goalService, index);
              }),
        )
      ]),
    ));
  }
}
