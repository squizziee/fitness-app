import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/base/training_regiment.dart';
import 'package:flutter_fitness_app/models/base/training_session.dart';
import 'package:flutter_fitness_app/repos/current_training_session.dart';
import 'package:flutter_fitness_app/services/auth.dart';
import 'package:flutter_fitness_app/services/database_service.dart';
import 'package:flutter_fitness_app/services/session_service.dart';
import 'package:flutter_fitness_app/views/misc/route_base_button.dart';
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

Widget _sessionWidget(BuildContext context,
    (TrainingSession, TrainingRegiment) tuple, SessionService sessionService) {
  var openedSessionIndex = sessionService.getOpenedSessionIndex(context);

  var session = tuple.$1;
  var regiment = tuple.$2;

  return GestureDetector(
    onTap: () async {
      await sessionService
          .copySession(context, session, openedSessionIndex)
          .then((value) => Navigator.of(context).pop());
    },
    child: Container(
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(width: 0.5, color: Color.fromRGBO(0, 0, 0, .1))),
      ),
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "[${regiment.name!}] #${session.dayInSchedule + 1} of ${regiment.cycleDurationInDays} — ${session.name == "" ? "No name" : session.name}",
          style:
              GoogleFonts.montserrat(fontWeight: FontWeight.w800, fontSize: 20),
        ),
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
        appBar: defaultAppBar(
            context,
            "Session #${(Provider.of<CurrentTrainingSession>(context).session!.dayInSchedule + 1).toString()}",
            "Session variants"),
        body: Column(
          children: [
            routeBaseButton(context, "/training_session_screen",
                FontAwesomeIcons.solidPenToSquare, "Edit session",
                topBorder: false),
            Container(
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        width: 0.5, color: Color.fromRGBO(0, 0, 0, .1))),
              ),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(20),
              child: Text(
                "Or choose existing session to copy:",
                style: GoogleFonts.roboto(fontSize: 14),
              ),
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
