import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/weight_training/weight_training_set.dart';
import 'package:flutter_fitness_app/services/weight_exercise_service.dart';
import 'package:flutter_fitness_app/views/misc/default_text_field.dart';

// Define a custom Form widget.
class SetEditingForm extends StatefulWidget {
  final WeightTrainingSet weightSet;
  final bool isNewSet;

  const SetEditingForm(
      {super.key, required this.weightSet, required this.isNewSet});

  @override
  SetEditingFormState createState() {
    return SetEditingFormState();
  }
}

class SetEditingFormState extends State<SetEditingForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _repetitionsController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  final WeightExerciseService _exerciseService = WeightExerciseService();

  void _clearControllers() {
    _weightController.text = "";
    _repetitionsController.text = "";
    _notesController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    _weightController.text = widget.weightSet.weightInKilograms.toString();
    _repetitionsController.text = widget.weightSet.repetitions.toString();
    _notesController.text = widget.weightSet.notes.toString();
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          formTextField(
              placeholder: "Weight(kg)",
              inputFormatters: [],
              controller: _weightController,
              validator: (value) {
                try {
                  var input = double.parse(value!);
                } catch (error) {
                  return "Wrong weight format";
                }
                return null;
              }),
          formTextField(
              placeholder: "Repetitions",
              inputFormatters: [],
              controller: _repetitionsController,
              validator: (value) {
                try {
                  var input = int.parse(value!);
                } catch (error) {
                  return "Wrong repetitions format";
                }
                return null;
              }),
          formTextField(
              placeholder: "Notes",
              inputFormatters: [],
              controller: _notesController,
              validator: (value) {
                return null;
              }),
          Padding(
            padding: const EdgeInsets.only(bottom: 5, top: 5, left: 10),
            child: Wrap(
              children: [
                widget.isNewSet
                    ? SizedBox()
                    : TextButton(
                        onPressed: () {
                          _exerciseService.removeSet(
                              context, widget.weightSet.setIndex);
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          setState(() {});
                        },
                        child: const Text(
                          'Delete',
                          style: TextStyle(color: Colors.redAccent),
                        ),
                      ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (widget.isNewSet) {
                        _exerciseService.addSet(
                          context,
                          _notesController.text,
                          int.parse(_repetitionsController.text),
                          double.parse(_weightController.text),
                        );
                      } else {
                        _exerciseService.updateSetWeight(
                            context,
                            widget.weightSet.setIndex,
                            double.parse(_weightController.text));
                        _exerciseService.updateSetRepetitions(
                            context,
                            widget.weightSet.setIndex,
                            int.parse(_repetitionsController.text));
                        _exerciseService.updateSetNotes(context,
                            widget.weightSet.setIndex, _notesController.text);
                      }

                      setState(() {});
                      _clearControllers();
                      Navigator.pop(context, 'OK');
                    }
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
