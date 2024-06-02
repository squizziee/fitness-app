import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/base/training_regiment.dart';
import 'package:flutter_fitness_app/models/base/training_session.dart';
import 'package:flutter_fitness_app/repos/current_training_session.dart';
import 'package:flutter_fitness_app/services/auth.dart';
import 'package:flutter_fitness_app/services/database_service.dart';
import 'package:flutter_fitness_app/services/session_service.dart';
import 'package:flutter_fitness_app/views/regiment_creation/common_widgets/app_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SelectTrainingSessionPage extends StatefulWidget {
  const SelectTrainingSessionPage({super.key});

  @override
  State<SelectTrainingSessionPage> createState() =>
      _SelectTrainingSessionPageState();
}

Widget _sessionWidget(
    BuildContext context,
    (TrainingSession, TrainingRegiment) session,
    SessionService sessionService) {
  var openedSessionIndex = sessionService.getOpenedSessionIndex(context);

  return GestureDetector(
    onTap: () async {
      await sessionService
          .copySession(context, session.$1, openedSessionIndex)
          .then((value) => Navigator.of(context).pop());
    },
    child: Container(
      color: const Color.fromARGB(31, 180, 180, 180),
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(20),
      child: Column(children: [
        Text(
            "Day ${session.$1.dayInSchedule + 1} of ${session.$2.cycleDurationInDays} of ${session.$2.name!}"),
        Text(session.$1.name == "" ? "No name" : session.$1.name),
      ]),
    ),
  );
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
  Future<List<(TrainingSession, TrainingRegiment)>>? sessionsList;
  final SessionService _sessionService = SessionService();

  @override
  void initState() {
    super.initState();
    sessionsList =
        DatabaseService().getAllUserTrainingSessions(Auth().currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar(
            context,
            "Session #${(Provider.of<CurrentTrainingSession>(context).session!.dayInSchedule + 1).toString()}",
            "Session variants"),
        body: Column(
          children: [
            _addTrainingSessionButton(context),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(20),
              child: const Text("Or choose existing session to copy:"),
            ),
            FutureBuilder(
                future: sessionsList,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else if (snapshot.hasData) {
                    return Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            var session = snapshot.data![index];
                            return _sessionWidget(
                                context, session, _sessionService);
                          }),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
          ],
        ),
      ),
    );
  }
}
