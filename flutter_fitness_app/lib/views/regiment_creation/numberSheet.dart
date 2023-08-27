import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/training_regiment.dart';
import 'package:flutter_fitness_app/views/regiment_creation/widgets/detailsPage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class NumberedSheet extends StatelessWidget {
  TrainingRegiment n;
  NumberedSheet({super.key, required this.n});

  @override
  Widget build(BuildContext context) {
    final FaIcon? icon = n.getTrainingType()?.getIcon();
    var mapOfDaysWithTraningSessions = {};
    for (final session in n.getSchedule()) {
      mapOfDaysWithTraningSessions[session.dayInSchedule] = session;
    }
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
        ),
        itemCount: n.getCycleDurationInDays(),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (mapOfDaysWithTraningSessions.containsKey(index + 1)) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsPage(
                        training: mapOfDaysWithTraningSessions[index + 1]),
                  ),
                );
              } else {}
            },
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  mapOfDaysWithTraningSessions.containsKey(index + 1)
                      ? icon ?? Container()
                      : Container(),
                  Text('Day ${index + 1}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
