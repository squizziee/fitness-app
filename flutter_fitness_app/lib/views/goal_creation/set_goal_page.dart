import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/goal.dart';
import 'package:flutter_fitness_app/models/weight_training/weight_exercise_type.dart';
import 'package:flutter_fitness_app/repos/current_goal.dart';
import 'package:flutter_fitness_app/services/custom_search_delegate.dart';
import 'package:flutter_fitness_app/services/database_service.dart';
import 'package:flutter_fitness_app/services/goal_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SetGoalPage extends StatefulWidget {
  const SetGoalPage({super.key});

  @override
  State<SetGoalPage> createState() => _SetGoalPageState();
}

Widget _tagWidget(String text, Color backgroundColor) {
  return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(5))),
      child: Text(text.toUpperCase(),
          style: GoogleFonts.montserrat(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              height: 1)));
}

Widget _field(String text, String placeholder, TextEditingController controller,
    TextInputType type) {
  controller.text = text;
  return TextField(
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
        labelText: placeholder,
        contentPadding:
            const EdgeInsets.only(left: 15, right: 10, top: 10, bottom: 10),
        filled: true,
        fillColor: const Color.fromARGB(31, 180, 180, 180),
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(50)),
      ));
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

  Widget _metricWidget(
      BuildContext context, GoalMetric metric, GoalService goalService) {
    return GestureDetector(
      onLongPress: () => showDialog<String>(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Confirmation'),
                content: Text(
                    'Are you sure you want to delete "${metric.metricName}"?'),
                actions: <Widget>[
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel')),
                  TextButton(
                      onPressed: () {
                        goalService.deleteMetric(context, metric.metricName!);
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
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          Text(
              "${metric.metricName} — ${metric.metricSize}${metric.metricScale}")
        ]),
      ),
    );
  }

  Widget _addMetricButton(BuildContext context) {
    return GestureDetector(
      onTap: () => showDialog<String>(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Add new metric'),
                content: Column(
                  children: [
                    _field("", "Metric name", _metricNameController,
                        TextInputType.name),
                    const SizedBox(height: 10),
                    _field("", "Metric size", _metricSizeController,
                        TextInputType.number),
                    const SizedBox(height: 10),
                    _field("", "Metric scale", _metricScaleController,
                        TextInputType.name),
                  ],
                ),
                actions: <Widget>[
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
                ],
              )),
      child: Container(
          height: 50,
          width: 50,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(100)),
              color: Color.fromRGBO(0, 0, 0, .05)),
          child: const Wrap(children: [
            FaIcon(
              FontAwesomeIcons.plus,
              size: 18,
            ),
          ])),
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
                      child: Wrap(
                        spacing: 15,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Container(
                              padding: const EdgeInsets.all(12),
                              decoration: const BoxDecoration(
                                  color: Color.fromRGBO(0, 0, 0, .05),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100))),
                              height: 60,
                              width: 60,
                              child: currentExercise == null
                                  ? const Icon(Icons.search)
                                  : Image.network(
                                      currentExercise!.iconURL,
                                      height: 20,
                                      width: 20,
                                    )),
                          Container(
                            child: currentExercise == null
                                ? Text('No exercise chosen',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        height: 1))
                                : Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    spacing: 6,
                                    children: [
                                        Text(currentExercise!.name,
                                            style: GoogleFonts.montserrat(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                                height: 1)),
                                        _tagWidget(currentExercise!.bodyPart,
                                            Colors.blueAccent),
                                        _tagWidget(currentExercise!.category,
                                            Colors.black87),
                                      ]),
                          ),
                        ],
                      )),
                );
              }
            }),
        ElevatedButton(
            onPressed: () async {
              datePicked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2025),
              );
              if (datePicked != null) {
                await _goalService.updateDeadline(context, datePicked!);
              }
              setState(() {});
            },
            child: Text(datePicked == null
                ? "Pick deadline date"
                : datePicked.toString())),
        _addMetricButton(context),
        Expanded(
          child: ListView.builder(
              itemCount: currentGoal.metrics!.length,
              itemBuilder: (context, index) {
                var metric = currentGoal.metrics!.toList()[index];
                return _metricWidget(context, metric, _goalService);
              }),
        )
      ]),
    ));
  }
}
